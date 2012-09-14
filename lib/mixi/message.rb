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
    # recipients : recipient user id
    # title
    # content
    # mixi.send("yce3fctj9i","test", "test")
    def send recipients, title, content

      endpoint = MESSAGE_ENDPOINT + "@me/@self/@outbox"
      data = {title: title, body: content, recipients: [recipients] }.to_json
      response = post_json(endpoint, data)
      parse(response)

    end

    # change inbox state
    # status: read or replied
    def inbox_state message_id, status = "read"
      endpoint = MESSAGE_ENDPOINT + "@me/@self/@inbox/#{message_id}"
      data = { status: status }.to_json
      response = put_json(endpoint, data)
      parse(response)
    end
    
    # change notice state
    def notice_state message_id
      endpoint = MESSAGE_ENDPOINT + "@me/@self/@noticebox/#{message_id}"
      data = { status: "read" }.to_json
      response = put_json(endpoint, data)
      parse(response)
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
