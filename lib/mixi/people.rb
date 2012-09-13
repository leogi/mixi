module Mixi
  class Client

    PEOPLE_ENDPOINT = "/2/people/"

    # need access token for "r_profile"
    # user's profile information
    def profile mixi_uid = "@me"
      response = get PEOPLE_ENDPOINT + "#{mixi_uid}/@self" 
      parse(response)
    end

    # user's friends list
    # 
    def friends mixi_uid = "@me"
      response = get(PEOPLE_ENDPOINT + "#{mixi_uid}/@friends")
      parse(response)
    end

    # access token for "r_profile_status"
    def status 
      response = get(PEOPLE_ENDPOINT + "@me/@friends?fields=status")
      parse(response)
    end
    # access token for "r_profile_last_login"
    def lastlogin
      response = get(PEOPLE_ENDPOINT + "@me/@friends?fields=lastLogin")
      parse(response)
    end

  end
end
