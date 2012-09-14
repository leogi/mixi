module Mixi
  class Client

    def profile_images user_id="@me", proimage_id = nil
      endpoint = "/2/people/images/#{user_id}/@self"
      endpoint += proimage_id if !proimage_id.nil?
      response = get(endpoint)
      parse(response)
    end

    PROFILE_IMAGE_PRIVACY_EVERYONE = "everyone"
    PROFILE_IMAGE_PRIVACY_FRIENDS = "friends"
    # data: image binary data
    def create_profile_image data, privacy , user_id="@me"
      endpoint = "/2/people/images/#{user_id}/@self?privacy=#{privacy}"
      response = post_binary(endpoint, data)
      parse(response)
    end

    def change_setting_profile_image image_id, privacy=PROFILE_IMAGE_PRIVACY_EVERYONE, primary= true, user_id="@me"
      endpoint = "/2/people/images/#{user_id}/@self/#{image_id}"
      params = { privacy: privacy, primary: primary }.to_json
      response = post_json(endpoint,params)
#      parse(response)
    end #not run

    def delete_profile_image image_id, user_id="@me"
      endpoint = "/2/people/images/#{user_id}/@me/@self/#{image_id}"
      response = delete(endpoint)
      response.class == Net::HTTPOK ? true : false
    end #not run

  end
end
