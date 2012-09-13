module Mixi
  class Client

    GROUP_ENDPOINT = "/2/groups/"

    def group mixi_uid = "@me"
      response = get GROUP_ENDPOINT + mixi_uid
      parse(response)
    end

  end
end
