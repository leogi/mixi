require 'test/unit'
require 'mixi'

class TestMixi < Test::Unit::TestCase
  CUSTOMER_KEY = "98d683f740723e8fed01" 
  CUSTOMER_SECRET = "8c1426e2437c74fa812e54e82e17fd22dfe0b262"
  MIXI_TOKEN = "3cedf38a0a27dc334b4f805621ab88d7733a7fd6"
  MIXI_REFRESH_TOKEN="9ba3916ce2d480aacc984fea4ccf292421f5421b"

#  def test_refresh_token_exe
#    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
#    old_token = mixi.token
#    mixi.refresh_token_exe
#    assert_not_equal old_token, mixi.token
#  end

#  def test_error_refresh_token_exe
#    mixi = Mixi::Client.new("adf","asdfads","gadadsf","adsfd")
#    assert_not_equal true, mixi.refresh_token_exe
#    mixi = Mixi::Client.new("98d683f740723e8fed01","8c1426e2437c74fa812e54e82e17fd22dfe0b262","3cedf38a0a27dc334b4f805621ab88d7733a7fd6","adsfd")
#    assert_not_equal true, mixi.refresh_token_exe
#  end

  def test_friends
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    
    # my friend
    #results = mixi.friends
    #assert_not_equal true, results.include?("error")
    # user friend
    uid = "ryq9eh9ai8osq"
    results = mixi.friends("ryq9ei8osq")
    assert_not_equal true, results.include?("error")
  end

#  def test_update_status
#    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
#    results = mixi.update_status("this is test")
#    assert_not_equal true, results.include?("error")
#  end

#  def test_parse
#    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
#    results = mixi.friends
#    assert_not_equal true, results.include?("error")
#  end



end
