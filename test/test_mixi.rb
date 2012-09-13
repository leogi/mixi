require 'test/unit'
require 'mixi'

class TestMixi < Test::Unit::TestCase
  CUSTOMER_KEY = "98d683f740723e8fed01" 
  CUSTOMER_SECRET = "8c1426e2437c74fa812e54e82e17fd22dfe0b262"
  MIXI_TOKEN = "3cedf38a0a27dc334b4f805621ab88d7733a7fd6"
  MIXI_REFRESH_TOKEN="9ba3916ce2d480aacc984fea4ccf292421f5421b"
  
  def test_send
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    
    #puts mixi.friends
    results = mixi.send("yce3fctj9ieqj","test","send form mixi gem")
    puts results
  end

=begin
  def test_delete
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)

    uid = "ryq9eh9ai8osq"
    results = mixi.delete_message("@me","@inbox","asdfagadfda")
    assert_equal false, results.has_key?("status")


    results = mixi.delete_message("@me","@inbox","352faa989da809108a05f5c1e94a3c78")
    assert_equal true, results.has_key?("status")
  end

  def test_message_notice
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)

    uid = "ryq9eh9ai8osq"

    results = mixi.noticebox
    puts results
    assert_equal true, results.has_key?("entry")

    results = mixi.noticebox(uid, nil)
    assert_equal true, results.has_key?("entry")


    results = mixi.noticebox("@me", "10c94944552c01e93eba67f87a04e484")
    puts results
    assert_equal true, results.has_key?("entry")

    results = mixi.noticebox(uid, "10c94944552c01e93eba67f87a04e484")
    assert_equal true, results.has_key?("entry")
    
  end

  def test_message_outbox
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)

    uid = "ryq9eh9ai8osq"

    results = mixi.outbox
    puts results
    assert_equal true, results.has_key?("entry")

    results = mixi.outbox(uid, nil)
    assert_equal true, results.has_key?("entry")


    results = mixi.outbox("@me", "880e7879673b184ccf4bcbfff2d74352")
    puts results
    assert_equal true, results.has_key?("entry")

    results = mixi.outbox(uid, "880e7879673b184ccf4bcbfff2d74352")
    assert_equal true, results.has_key?("entry")
    
  end

  def test_message_inbox
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)

    uid = "ryq9eh9ai8osq"

    results = mixi.inbox
    puts results
    assert_equal true, results.has_key?("entry")

    results = mixi.inbox(uid, nil)
    assert_equal true, results.has_key?("entry")


    results = mixi.inbox("@me", "352faa989da809108a05f5c1e94a3c78")
    puts results
    assert_equal true, results.has_key?("entry")

    results = mixi.inbox(uid, "352faa989da809108a05f5c1e94a3c78")
    assert_equal true, results.has_key?("entry")
    
  end

  def test_updates
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)

    # mixi_uid: @me
    results = mixi.updates
    assert_equal true, results.has_key?("entry")

    results = mixi.updates("@me","@friends")
    assert_equal true, results.has_key?("entry")

    results = mixi.group
    group_id = results["entry"].first["id"]
    assert_not_equal nil, group_id

    results = mixi.updates("@me",group_id)
    assert_equal true, results.has_key?("entry")
    
    # mixi_uid: "ryq9eh9ai8osq"
    uid = "ryq9eh9ai8osq"
    results = mixi.updates(uid,nil)
    assert_equal true, results.has_key?("entry")

    results = mixi.updates(uid,"@friends")
    assert_equal true, results.has_key?("entry")

    results = mixi.group
    group_id = results["entry"].first["id"]
    assert_not_equal nil, group_id

    results = mixi.updates(uid,group_id)
    assert_equal true, results.has_key?("entry")
  
  end

  def test_search
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    
    # self profile
    email = "norifumi.homma@ezweb.ne.jp"
    results = mixi.search("@friends", email)
    assert_equal false, results.has_key?("entry")
   
    results = mixi.search("@all",email)
    assert_equal true, results.has_key?("entry")
   
    results = mixi.group
    group_id = results["entry"].first["id"]
    
    result = mixi.search(group_id, email)
    assert_equal true, results.has_key?("entry")
   
  end

  def test_group
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    
    # self profile
    results = mixi.group
    assert_equal true, results.has_key?("entry")
    # user profile
    
    results = mixi.group("ryq9ei8osq")
    assert_equal true, results.has_key?("error")

    uid = "ryq9eh9ai8osq"
    results = mixi.group(uid)
    assert_equal true, results.has_key?("entry")
   
  end

  def test_lastlogin
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    # self profile
    results = mixi.lastlogin
    assert_equal true, results.has_key?("entry")
    # user profile
  end

  def test_status
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    # self profile
    results = mixi.status
    assert_equal true, results.has_key?("entry")
    # user profile
  end

  def test_profile
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)

    # self profile
    results = mixi.profile
    assert_equal true, results.has_key?("entry")
    # user profile
    
    results = mixi.profile("ryq9ei8osq")
    assert_equal true, results.has_key?("error")

    uid = "ryq9eh9ai8osq"
    results = mixi.profile(uid)
    assert_not_equal true, results.has_key?("error")
    
  end
=end
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

#  def test_friends
#    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    
    # my friend
#    results = mixi.friends
#    assert_not_equal true, results.has_key?("error")
    # user friend
#    uid = "ryq9eh9ai8osq"
#    results = mixi.friends("ryq9ei8osq")
#    assert_equal true, results.has_key?("error")

#    results = mixi.friends(uid)
#    assert_not_equal true, results.has_key?("error")

#  end

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
