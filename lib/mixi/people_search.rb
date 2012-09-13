module Mixi
  class Client
    PEOPLE_ENDPOINT_SEARCH = "/2/search/people/"

    # group_id: mixi group id or "@friends" or "@all", default is "@friends"
    def search group_id="@friends", email
      
      response = get PEOPLE_ENDPOINT_SEARCH + "#{group_id}?q=#{email}"
      parse(response)

    end

  end
end
