module Mixi

  class Client
    
    MESSAGE_ENDPOINT = "/2/messages/"

    # get inbox message
    def inbox mixi_uid = "@me", message_id = nil

      response = nil
      if message_id.nil?
        response = get MESSAGE_ENDPOINT + "#{mixi_uid}/@inbox/"
      else
        response = get MESSAGE_ENDPOINT + "#{mixi_uid}/@inbox/#{message_id}"
      end
      parse(response)

    end

    # get outbox message
    def outbox mixi_uid = "@me", message_id = nil

      response = nil
      if message_id.nil?
        response = get MESSAGE_ENDPOINT + "#{mixi_uid}/@outbox/"
      else
        response = get MESSAGE_ENDPOINT + "#{mixi_uid}/@outbox/#{message_id}"
      end
      parse(response)

    end

    # get notice form mixi
    def noticebox mixi_uid = "@me", message_id = nil

      response = nil
      if message_id.nil?
        response = get MESSAGE_ENDPOINT + "#{mixi_uid}/@noticebox/"
      else
        response = get MESSAGE_ENDPOINT + "#{mixi_uid}/@noticebox/#{message_id}"
      end
      parse(response)

    end

    # send message
    def send recipients, title, content
      endpoint = MESSAGE_ENDPOINT + "@me/@self/@outbox"
      params= "title=#{title}&body=#{content}&recipients=#{recipients}"
      response = post(endpoint, params)
      parse(response)
    end

    # change inbox state
    def inbox_state

    end
    
    # change notice state
    def notice_state

    end

    # delete message
    def delete_message mixi_uid ="@me", type, message_id 
      response = delete( MESSAGE_ENDPOINT + "#{mixi_uid}/@self/#{type}/#{message_id}")
      parse(response)
    end

    def delete_inbox mixi_uid = "@me", message_id
      delete_message(mixi_uid, "@inbox", message_id)
    end

    def delete_outbox mixi_uid = "@me", message_id
      delete_message(mixi_uid, "@outbox", message_id)
    end

    def delete_noticebox mixi_uid = "@me", message_id
      delete_message(mixi_uid, "@noticebox", message_id)
    end

  end
end
