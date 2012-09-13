module Connection

  def post(endpoint, params, token)
    https = NET::HTTP.new("api.mixi-platform.com", 443)
    https.use_ssl = true

    https.start do
      response = https.post(endpoint, params, {'Authorization' => "OAuth #{token}",'HOST' => 'api.mixi-platform.com'})
    end
  end

  def get(endpoint, token)
    http = NET::HTTP.new("api.mixi-platform.com", 80)
    http.start do
      response = http.get(endpoint, {'Authorization' => "OAuth #{token}",'HOST' => 'api.mixi-platform.com'})
    end
  end
end
