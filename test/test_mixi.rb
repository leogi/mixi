require 'test/unit'
require 'mixi'

class TestMixi < Test::Unit::TestCase
  CUSTOMER_KEY = "98d683f740723e8fed01" 
  CUSTOMER_SECRET = "8c1426e2437c74fa812e54e82e17fd22dfe0b262"
  MIXI_TOKEN = "3cedf38a0a27dc334b4f805621ab88d7733a7fd6"
  MIXI_REFRESH_TOKEN="9ba3916ce2d480aacc984fea4ccf292421f5421b"

=begin
  def test_change_setting_profile_image # test fails
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    #results = mixi.profile_images
    data = IO.binread("/home/nghialv/mylove.jpg")
    r = mixi.create_profile_image(data, Mixi::Client::PROFILE_IMAGE_PRIVACY_EVERYONE)
    puts r["id"]
    results = mixi.change_setting_profile_image(r["id"])
    assert_equal true, results.include?("id")
  end



  def test_create_profile_image
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    data = IO.binread("/home/nghialv/mylove.jpg")
    results = mixi.create_profile_image(data, Mixi::Client::PROFILE_IMAGE_PRIVACY_EVERYONE)
    assert_equal true, results.include?("id")
  
  end

  def test_profile_images
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.profile_images
    puts results
    assert_equal true, results.has_key?("entry")
  end

  def test_add_photo_album
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
   
    data = IO.binread("/home/nghialv/background.jpg")
    results = mixi.add_photo_album(data, "500000072105139","nghia yeu diu")
    assert_equal true, results.include?("id")
  end

  def test_delete_like_photo
    
  end
  def test_add_like_photo

  end

  def test_delete_comment_album
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.album_photos("@me","500000072105139")
    photo = results["entry"].first
    comments = mixi.photo_comments(photo["id"], "@me","500000072105139")
    comments["entry"].each do |comment|
      puts comment
      assert_equal true, mixi.delete_comment_photo(comment["id"], photo["id"], "500000072105139")
    end
  end

  def test_add_comment_album
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.album_photos("@me","500000072105139")
    photo = results["entry"].first
    
    results = mixi.add_comment_photo("nghia yeu diu", photo["id"], "500000072105139")
    #puts photo
    assert_equal true, results
    
  end

  def test_delete_photo_album
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.album_photos("@me","500000072105139")
    results["entry"].each do |photo|
      puts photo
      assert_equal true, mixi.delete_photo_album(photo["id"],"500000072105139")
    end
  end

  def test_add_comment_album
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
  
    #results = mixi.create_album("nghia yeu diu","description",Mixi::Client::VISIBILITY_EVERYONE)
    #puts id = results["id"]
  
    results = mixi.album_comments("@me", "500000072105139")
    results["entry"].each do |comment|
      puts comment
      r = mixi.delete_comment_album(comment["id"],"500000072105139")
      assert_equal true, r
    end
  
  end

  def test_delete_album
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
  
    results = mixi.create_album("nghia yeu diu","description",Mixi::Client::VISIBILITY_EVERYONE)
    id = results["id"]
    assert_equal true, results.include?("id")
  
    results = mixi.delete_album(id)
    assert_equal true, results
    assert_equal false, mixi.delete_album("testsdaf")
  
  end

  def test_create_albums
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.create_album("nghia yeu diu","description",Mixi::Client::VISIBILITY_EVERYONE)
    puts results
    assert_equal true, results.include?("id")
  end

  def test_photo_likes
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.photo_likes("1771292073","@me","500000070557386")
    puts results
    assert_equal true, results.has_key?("entry")
  end

  def test_photo_comments
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.photo_comments("1771292073","@me","500000070557386")
    puts results
    assert_equal true, results.has_key?("entry")
  end

  def test_album_comments
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.album_comments("@me","500000070557386")
    puts results
    assert_equal true, results.has_key?("entry")
  end

  def test_friends_photos
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.friends_photos
    puts results
    assert_equal true, results.has_key?("entry")
  end

  def test_album_photos
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.album_photos("@me","500000070557386")
    puts results
    assert_equal true, results.has_key?("entry")

  end

  def test_friends_albums
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.friends_albums
    puts results
    assert_equal true, results.has_key?("entry")

  end
  def test_albums
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.albums
    assert_equal true, results.has_key?("entry")

    results = mixi.albums("@me","500000070489998")
    assert_equal true, results.has_key?("entry")
  end

  def test_like_post
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    #puts mixi.friends_voice_posts
    results = mixi.like_post("uqdfyi89tg5s8-20120913221158")
    assert_equal true, results.include?("id")

    results = mixi.delete_like_post("uqdfyi89tg5s8-20120913221158")
    assert_equal true, results.include?("id")
  end

  def test_delete_comment_post
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.delete_comment_post("ryq9eh9ai8osq-20120914133746", "ryq9eh9ai8osq-20120914133746-ryq9eh9ai8osq-20120914133846")
    assert_equal "ryq9eh9ai8osq-20120914133746-ryq9eh9ai8osq-20120914133846", results["id"]
  end

  def test_comment_post
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.comment_post("ryq9eh9ai8osq-20120914133746", "test")
    
    id = results["id"]
    assert_equal true, results.include?("id")

  end

  def test_delete_post
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.delete_post("ryq9eh9ai8osq-20120914132228")
    assert_equal false, results.include?("id")
    results = mixi.show_post("ryq9eh9ai8osq-20120914132228")
    assert_equal false, results.include?("id")
  end
  
  def test_posting
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.posting("send form snap")
    assert_equal true, results.include?("id")
  end


 def test_likes_post
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.likes_post("asdfasdf")
    if results.class == Hash
      assert_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end
    
    results = mixi.likes_post("5geksbk9y57hg-20120913224039")
    puts results
    if results.class == Hash
      assert_not_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end
    
  end

  def test_show_post
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.comments_post("asdfasdf")
    if results.class == Hash
      assert_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end
    
    results = mixi.comments_post("5geksbk9y57hg-20120913224039")
    puts results
    if results.class == Hash
      assert_not_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end
    
  end



  def test_show_post
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.show_post("asdfasdf")
    if results.class == Hash
      assert_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end
    
    results = mixi.show_post("5geksbk9y57hg-20120913224039")
    puts results
    if results.class == Hash
      assert_not_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end
    
  end

def test_friends_voice_posts
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.friends_voice_posts
    puts results
    if results.class == Hash
      assert_not_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end

    results = mixi.friends_voice_posts("ryq9eh9ai8osq-20120913151318")
    puts results
    if results.class == Hash
      assert_not_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length  
    end
   
  end



  def test_voice_posts
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    results = mixi.voice_posts
    if results.class == Hash
      assert_not_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length
    end

    results = mixi.voice_posts("ryq9eh9ai8osq-20120913151318")
    
    if results.class == Hash
      assert_not_equal true, results.has_key?("error")
    else
      assert_not_equal 0, results.length  
    end
   
  end


  def test_inbox_status
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    #puts mixi.inbox
    results= mixi.inbox_state("573f681bb068826dd290b5e6646d606a", "replied")
    assert_not_equal true, results.has_key?("error")
  end

  def test_send
    mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)
    
    results = mixi.send("yce3fctj9ieqj","test", "test")
    assert_not_equal true, results.has_key?("error")
    
    results = mixi.send("yce3fctj9i","test", "test")
    assert_equal true, results.has_key?("error")
  end

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
