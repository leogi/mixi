module Mixi
  class Client
    
    VOICE_ENDPOINT = "/2/voice/statuses/"
    # self voice posts
    def voice_posts post_id = nil
      endpoint = VOICE_ENDPOINT + "@me/user_timeline"
      if !post_id.nil?
        endpoint += "?since_id=#{post_id}"
      end
      response = get(endpoint)
      parse(response)
    end

    # friend voice posts
    def friends_voice_posts group_id = nil, post_id = nil
      endpoint = VOICE_ENDPOINT + "friends_timeline/"
      endpoint += group_id if !group_id.nil?
      endpoint += "?since_id=#{post_id}"
      response = get(endpoint)
      parse(response)
    end

    # post details
    def show_post post_id
      endpoint = VOICE_ENDPOINT + "show/#{post_id}"
      response = get(endpoint)
      parse(response)
    end

    # list of post's comments
    def comments_post post_id
      endpoint = "/2/voice/replies/show/#{post_id}"
      response = get(endpoint)
      parse(response)
    end
    
    # list of post's likes
    def likes_post post_id
      endpoint = "/2/voice/favorites/show/#{post_id}"
      response = get(endpoint)
      parse(response)
    end

    # post a voice
    def posting status
       endpoint = "/2/voice/statuses/update"
       params = "status=#{status}"
       response = post(endpoint, params)
       parse(response)
    end

    # post a voice with image
    def posting_with_image status, data
      endpoint = "/2/voice/statuses/update?status=#{status}"
      response = post_binary(endpoint, data)
      parse(response)

    end

    # delete a voice post
    def delete_post post_id
      endpoint = "/2/voice/statuses/destroy/#{post_id}"
      response = delete(endpoint)
      parse(response)
    end

    # comment to a post
    def comment_post post_id, text
      endpoint = "/2/voice/replies/create/#{post_id}"
      params = "text=#{text}"
      response = post(endpoint, params)
      parse(response)
    end

    # delete comment of a post
    def delete_comment_post post_id, comment_id
      endpoint = "/2/voice/replies/destroy/#{post_id}/#{comment_id}"
      response = delete(endpoint)
      parse(response)
    end

    # like a post
    def like_post post_id
      endpoint = "/2/voice/favorites/create/#{post_id}"
      params = ""
      response = post(endpoint, params)
      parse(response)
    end

    # delete comment of a post
    def delete_like_post post_id, user_id = "@me"
      endpoint = "/2/voice/favorites/destroy/#{post_id}/#{user_id}"
      response = delete(endpoint)
      parse(response)
    end
  end
end
