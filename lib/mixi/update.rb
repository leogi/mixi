module Mixi
  class Client

    UPDATE_ENDPOINT = "/2/updates/"

    # Getting a list of feeds
    # mixi_uid: user'S id or @me
    # group_id:  group id, or @self, or @friends
    def updates mixi_uid = "@me", group_id = "@self"
      response = get UPDATE_ENDPOINT + "#{mixi_uid}/#{group_id}"
      parse(response)
    end

  end
end
