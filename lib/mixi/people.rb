module Mixi
  class Client

    PEOPLE_ENDPOINT = "/2/people/"

    def profile mixi_uid

    end

    def friends mixi_uid = "@me"
      response = get(PEOPLE_ENDPOINT + "#{mixi_uid}/@friends")
      #parse(response)
    end

  end
end
