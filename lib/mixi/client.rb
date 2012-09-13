 require "mixi/version"
 require "net/http"
 require "net/https"
 require "openssl"
 require "json"
 
 
 require "mixi/connection"
 require "mixi/people"
 require "mixi/group"
 require "mixi/people_search"
 require "mixi/update"
 require "mixi/message"
 module Mixi
   # Your code goes here...
   class Client
     
     # initialize
     # customer_key: mixi customer_key
     # customer_secret: mixi customer key
     # mixi_token : token
     # mixi_refresh_token:  refresh_token
     
     
     def initialize(customer_key, 
                    customer_secret,
                    mixi_token,
                    mixi_refresh_token)
       @customer_key = customer_key
       @customer_secret = customer_secret
       @token = mixi_token
       @refresh_token = mixi_refresh_token
      @errors = []
     end
     
     # refresh token
     def refresh_token_exe
       
       https = Net::HTTP.new("secure.mixi-platform.com", 443)
       https.use_ssl = true
       https.verify_mode = OpenSSL::SSL::VERIFY_PEER
       https.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs')
       
       params = "grant_type=refresh_token&client_id=#{@customer_key}&client_secret=#{customer_secret}&refresh_token=#{@refresh_token}"
       
       https.start{
         
         response = https.post('/2/token',params)
         
         if response.class == Net::HTTPOK
           json_result = JSON.parse(response.body)
           @token = json_result["access_token"]
           return true
         elsif response.class == Net::HTTPUnauthorized
           @errors << "Net::Unauthorized"
         end
       }
       return false
       
     end
     
     # get mixi friend
     #def friends
     #  response = get("/2/people/@me/@friends")
     #  parse(response)
     #end
     
     # update status
     def update_status status
       endpoint = "/2/voice/statuses/update"
       params = "status=#{status}"
       response = post(endpoint, params)
       parse(response)
     end
     
     def parse http_response
       results = Hash.new
       if http_response.class == Net::HTTPOK
         results = JSON.parse(http_response.body)
       else
         results["error"] = http_response.class.name
       end
       results
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
     
     def errors
      @errors
     end
     
   end
 end
 
