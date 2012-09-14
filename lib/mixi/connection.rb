module Mixi
  class Client
    
    def post_binary endpoint, data
      
      https = Net::HTTP.new("api.mixi-platform.com", 443)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      https.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs')#ubuntu
      
      https.start do
        response = https.request(prepare_binary_post_request(endpoint, data))
        if response.class == Net::HTTPUnauthorized
          refresh_token_exe
          response = https.request(prepare_binary_post_request(endpoint, data))
        end
        response
      end

    end

    def prepare_binary_post_request endpoint, data
      request = Net::HTTP::Post.new(endpoint)
      request["content-type"] = "image/jpeg"
      request["Authorization"] = "OAuth #{@token}"
      request["HOST"] = "api.mixi-platform.com"

      body = []
      body << data
      request.body = body.join

      request
    end

    def post_json endpoint, json_data

      https = Net::HTTP.new("api.mixi-platform.com", 443)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      https.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs')#ubuntu
      
      https.start do
        response = https.request(prepare_json_post_request(endpoint, json_data))
        if response.class == Net::HTTPUnauthorized
          refresh_token_exe
          response = https.request(prepare_json_post_request(endpoint, json_data))
        end
        response
      end

    end
    

    def put_json endpoint, json_data

      https = Net::HTTP.new("api.mixi-platform.com", 443)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      https.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs')#ubuntu
      
      https.start do
        response = https.request(prepare_json_put_request(endpoint, json_data))
        if response.class == Net::HTTPUnauthorized
          refresh_token_exe
          response = https.request(prepare_json_put_request(endpoint, json_data))
        end
        response
      end

    end

    def prepare_json_put_request endpoint, data

      request = Net::HTTP::Put.new(endpoint, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
      request["content-type"] = 'application/json'
      request.body = data

      request

    end
   
    def prepare_json_post_request endpoint, data

      request = Net::HTTP::Post.new(endpoint, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
      request["content-type"] = 'application/json'
      request.body = data

      request

    end
    # post
    # return http response
    def post(endpoint, params)

      https = Net::HTTP.new("api.mixi-platform.com", 443)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      https.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs')#ubuntu
      #https.ca_file = '/opt/local/share/curl/curl-ca-bundle.crt' if File.exists?('/opt/local/share/curl/curl-ca-bundle.crt') # Mac OS X
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
      http.get(endpoint,{'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
    end

    def delete_exe(http, endpoint)
      http.delete(endpoint, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
    end


    def put_exe(http, endpoint, params)
      http.put(endpoint, params, {'Authorization' => "OAuth #{@token}",'HOST' => 'api.mixi-platform.com'})
    end

  end
end
