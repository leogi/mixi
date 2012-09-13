module Mixi
  class Client
    # post
    # return http response
    def post(endpoint, params)

      https = Net::HTTP.new("api.mixi-platform.com", 443)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      https.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs')
      
      https.start do
        response = post_exe(https, endpoint, params)

        if response.class == Net::HTTPUnauthorized
          refresh_token_exe
          response = post_exe(https, endpoint, params)
        end

        response
      end      

    end
    
    # get
    # return http response
    def get(endpoint)

      http = Net::HTTP.new("api.mixi-platform.com", 80)
      http.start do
        response = get_exe(http, endpoint)
       
        if response.class == Net::HTTPUnauthorized
          refresh_token_exe
          response = get_exe(http, endpoint)
        end
        response
      end

    end 

    def delete endpoint

      http = Net::HTTP.new("api.mixi-platform.com", 80)
      http.start do
        response = delete_exe(http, endpoint)
       
        if response.class == Net::HTTPUnauthorized
          refresh_token_exe
          response = delete_exe(http, endpoint)
        end
        response
      end

    end


    def put endpoint, params

      http = Net::HTTP.new("api.mixi-platform.com", 80)
      http.start do
        response = put_exe(http, endpoint, params)
       
        if response.class == Net::HTTPUnauthorized
          refresh_token_exe
          response = put_exe(http, endpoint, params)
        end
        response
      end

    end

    def post_exe (https, endpoint, params)
      https.post(endpoint, params, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
    end

    def get_exe(http, endpoint)
      http.get(endpoint, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
    end

    def delete_exe(http, endpoint)
      http.delete(endpoint, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
    end


    def put_exe(http, endpoint, params)
      http.put(endpoint, params, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
    end

  end
end
