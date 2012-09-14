module Mixi

  class Client

    def albums user_id = "@me", album_id = nil, accessKey = nil
      endpoint = "/2/photo/albums/#{user_id}/@self/"
      endpoint += album_id if !album_id.nil?
      endpoint += "?accessKey=#{accessKey}"
      response = get(endpoint)
      parse(response)
    end
    
    def friends_albums user_id = "@me", group_id ="@friends"
      endpoint ="/2/photo/albums/#{user_id}/#{group_id}"
      response = get(endpoint)
      parse(response)
    end

    def album_photos user_id = "@me", album_id ="@default", item_id= nil, accessKey=nil
      endpoint = "/2/photo/mediaItems/#{user_id}/@self/#{album_id}"
      endpoint += "/#{item_id}" if !item_id.nil?
      endpoint += "?accessKey=#{accessKey}"
      response = get(endpoint)
      parse(response)
    end

    # list of photos recently uploaded by friends
    def friends_photos user_id = "@me", group_id ="@friends"
      endpoint = "/2/photo/mediaItems/#{user_id}/#{group_id}"
      response = get(endpoint)
      parse(response)
    end

    # list of comments added to an album
    def album_comments user_id="@me",album_id="@default", accessKey=nil
      endpoint = "/2/photo/comments/albums/#{user_id}/@self/#{album_id}"
      endpoint += "?accessKey=#{accessKey}" if !accessKey.nil?
      response = get(endpoint)
      parse(response)
    end

    # list of comments added to an photo
    def photo_comments(photo_id,user_id="@me",album_id="@default",accessKey=nil)
      endpoint = "/2/photo/comments/mediaItems/#{user_id}/@self/#{album_id}/#{photo_id}"
      endpoint += "?accessKey=#{accessKey}" if !accessKey.nil?
      response = get(endpoint)
      parse(response)
    end
    
    # list of likes added to a photo
    def photo_likes photo_id, user_id="@me", album_id="@default", accessKey=nil
      endpoint = "/2/photo/favorites/mediaItems/#{user_id}/@self/#{album_id}/#{photo_id}"
      endpoint += "?accessKey=#{accessKey}" if !accessKey.nil?
      response = get(endpoint)
      parse(response)
    end

    VISIBILITY_EVERYONE = "everyone"
    VISIBILITY_FRIENDS = "friends"
    VISIBILITY_FRIENDS_OF_FRIENDS = "friends_of_friends"
    VISIBILITY_TOP_FRIENDS = "top_friends"
    VISIBILITY_ACCESS_KEY = "access_key"
    VISIBILITY_SELF = "self"

    def create_album title, description, visibility=VISIBILITY_EVERYONE, user_id ="@me", accessKey=nil
      endpoint = "/2/photo/albums/#{user_id}/@self"
      params = "title=#{title}&description=#{description}&visibility=#{visibility}"
      params += "&accessKey=#{accessKey}" if !accessKey.nil?
      response = post(endpoint, params)
      parse(response)
    end

    def delete_album album_id="@default", user_id="@me"
      endpoint = "/2/photo/albums/#{user_id}/@self/#{album_id}"
      response = delete(endpoint)
      if response.class == Net::HTTPOK
        return true
      else
        return false
      end
    end

    def add_comment_album comment, album_id="@default", user_id="@me", accessKey=nil
      endpoint = "/2/photo/comments/albums/#{user_id}/@self/#{album_id}"
      params = "text=#{comment}"
      params += accessKey.nil? ? "" : "&accessKey=#{accessKey}"
      response = post(endpoint, params)
      if response.class == Net::HTTPCreated
        return true
      else
        return false
      end
    end

    def delete_comment_album comment_id, album_id="@default", user_id="@me", accessKey=nil
      endpoint = "/2/photo/comments/albums/#{user_id}/@self/#{album_id}/#{comment_id}"
      endpoint += "?accessKey=#{accessKey}" if !accessKey.nil?
      response = delete(endpoint)
      if response.class == Net::HTTPOK
        return true
      else
        return false
      end
    end

    # data: image binary data
    def add_photo_album data, album_id, title=nil, user_id="@me"
      endpoint = "/2/photo/mediaItems/#{user_id}/@self/#{album_id}"
      endpoint += "?title=#{title}" if !title.nil?
      response = post_binary(endpoint, data)
      parse(response)
    end

    def delete_photo_album photo_id, album_id, user_id="@me"
      endpoint = "/2/photo/mediaItems/#{user_id}/@self/#{album_id}/#{photo_id}"
      response = delete(endpoint)
      if response.class == Net::HTTPOK
        return true
      else
        return false
      end
    end

    def add_comment_photo comment, photo_id, album_id, user_id="@me", accessKey=nil
      endpoint = "/2/photo/comments/mediaItems/#{user_id}/@self/#{album_id}/#{photo_id}"
      params = "text=#{comment}"
      params += "&accessKey=#{accessKey}" if !accessKey.nil?
      response = post(endpoint, params)
      if response.class == Net::HTTPCreated
        return true
      else
        return false
      end
    end
    
    def delete_comment_photo comment_id, photo_id, album_id, user_id="@me", accessKey=nil
      endpoint = "/2/photo/comments/mediaItems/#{user_id}/@self/#{album_id}/#{photo_id}/#{comment_id}"
      endpoint += "?accessKey=#{accessKey}" if !accessKey.nil?
      response = delete(endpoint)
      if response.class == Net::HTTPOK
        return true
      else
        return false
      end
    end

    def add_like_photo photo_id, album_id, user_id, accessKey=nil
      endpoint = "/2/photo/favorites/mediaItems/#{user_id}/@self/#{album_id}/#{photo_id}"
      params = "accessKey=#{accessKey}" if !accessKey.nil?
      response = post(endpoint, params)
      if response.class == Net::HTTPCreated
        true
      else
        false
      end
    end
    
    def delete_like_photo photo_id, album_id, favorite_user_id, user_id="@me", accessKey=nil
      endpoint = "/2/photo/favorites/mediaItems/#{user_id}/@self/#{album_id}/#{photo_id}/#{favorite_user_id}"
      endpoint += "?accessKey=#{accessKey}" if !accessKey.nil?
      response = delete(endpoint)
      if response.class == Net::HTTPOK
        return true
      else
        return false
      end

    end

  end
end
