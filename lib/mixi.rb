require "mixi/version"
require "net/http"
require "json"

module Mixi
  # Your code goes here...
  class Mixi
    @refresh_token_endpoint = "/2/token"
    @friends_endpoint = "/2/people/@me/@friends"
    #def initialize
    #  @consumer_key= "98d683f740723e8fed01"
    #  @consumer_secret= "8c1426e2437c74fa812e54e82e17fd22dfe0b262"
    #  @token = "3cedf38a0a27dc334b4f805621ab88d7733a7fd6"
    #  @refresh_token = "9ba3916ce2d480aacc984fea4ccf292421f5421b"
    #end
  
    def initialize(customer_key="98d683f740723e8fed01", 
                   customer_secret="8c1426e2437c74fa812e54e82e17fd22dfe0b262",
                   mixi_token="3cedf38a0a27dc334b4f805621ab88d7733a7fd6",
                   mixi_refresh_token="9ba3916ce2d480aacc984fea4ccf292421f5421b")
      @customer_key = customer_key
      @customer_secret = customer_secret
      @token = mixi_token
      @refresh_token = mixi_refresh_token
    end
    
    def refresh_token_exe
      
      https = Net::HTTP.new("http://secure.mixi-platform.com/", 443)
      https.use_ssl = true
      
      params = "grant_type=refresh_token&client_id=#{@customer_key}&client_secret=#{customer_secret}&refresh_token=#{@refresh_token}"
      
      https.start{
        response = https.post('/2/token',params)
      }
      
      if response.class == Net::HTTPOK
        json_result = JSON.parse(response.body)
        @token = json_result["access_token"]
        return true
      end
      return false
      
    end

    def friends
      get(@friend_endpoint)
    end

    def post(endpoint, params)
      https = NET::HTTP.new("api.mixi-platform.com", 443)
      https.use_ssl = true
      
      https.start do
        response = https.post(endpoint, params, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
      end

    end
    
    def get(endpoint)
      http = NET::HTTP.new("api.mixi-platform.com", 80)
      http.start do
        response = http.get(endpoint, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
      end
      response
    end 

    def token
      @token
    end

    def refresh_token
      @refresh_token
    end
    
    def customer_key
      @customer_key
    end

    def customer_secret
      @customer_secret
    end
  end
end
