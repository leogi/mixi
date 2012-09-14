# Mixi

This is a Mixi library for Ruby

Supporting feature:
- people api:
  - extracting the list of friend
  - extracting a status update
  - extracting log in status updates
  - extracting profile infomation
 
- groups api
  - extracting group list

- people lookup api
  - extracting profile infomation from email address

- updates api
  - getting a list of friends
  
- voice api
  - acquiring a list of a user's (or user's friend's) mixi voice post
  - acquiring a list of comments, likes for a mixi Voice post
  - posting and deleting a mixi Voice post
  - like and comment for a mixi Voice post

- photo api
  - acquiring album, photo, comment, like of photo
  - uploading, deleting photo
  - adding, deleting album's comment, photo's comment
  - adding, deleting a photo's "like"

- message api
  - obtaining, deleting inbox, outbox, mixi's notice message
  - sending mixi's message

- profile image api
  - obtaining, creating, changing, deleting

## Installation

Add this line to your application's Gemfile:

    gem 'mixi', git: "https://github.com/dainghiavotinh/mixi.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mixi

## Usage

create mixi instance

CUSTEMER_KEY		: customer key
CUSTOMER_SECRET	        : customer secret
MIXI_TOKEN 	 	: mixi token (obtained by omiauth)
MIXI_REFRESH_TOKEN	: mixi refresh token (obtained by omiauth)

   mixi = Mixi::Client.new(CUSTOMER_KEY, CUSTOMER_SECRET, MIXI_TOKEN, MIXI_REFRESH_TOKEN)

extracting the list of friend      

   results = mixi.friends

create a mixi voice post with a photo
  
   data = IO.binread("path to photo")
   results = mixi.posting_with_photo("status", data)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
