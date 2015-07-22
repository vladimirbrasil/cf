require 'net/http'
require 'json'

class Token
  extend ActiveSupport::Concern

  def initialize(account)
    @account = account
  end

  def fresh_token
    refresh! if expired?
    @account.oauth_token
  end

  def to_params
    {'refresh_token' => @account.oauth_refresh_token,
    'client_id' => ENV['GOOGLE_CLIENT_ID'], 
    'client_secret' => ENV['GOOGLE_SECRET'], 
    'grant_type' => 'refresh_token'}
  end 

  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, to_params)
  end
 
  def refresh!
    response = request_token_from_google
    data = JSON.parse(response.body)
    puts "response: #{data}"
    @account.update_attributes(
      oauth_token: data['access_token'],
      oauth_expires: Time.now + (data['expires_in'].to_i).seconds
    )
  end
 
  def expired?
    @account.oauth_expires < Time.now
  end

end

=begin
https://www.twilio.com/blog/2014/09/gmail-api-oauth-rails.html

to_params
Converts the token’s attributes into a hash with the key names 
that the Google API expects for a token refresh. For more 
information on why these are the way they are, check out the 
docs for how to refresh a Google API token.

request_token_from_google
Makes a http POST request to the Google API OAuth 2.0 
authorization endpoint using parameters from above. Google 
returns JSON data that includes an access token good for 
another 60 minutes. Again, the the Google API docs have more 
information on how this works.

refresh!
Requests the token from Google, parses its JSON response and 
updates your database with the new access token and expiration 
date.

expired?
Returns true if your access token smells like spoiled milk.

fresh_token
A convenience method to return a valid access token, refreshing 
if necessary.

One last note about the tokens table: for simplicity’s sake 
I wrote this tutorial to only work with a single email address 
but it won’t be difficult to add support for multiple accounts 
if you build a service for multiple users. Google sends the 
users’s email address to the callback url. Add an email column 
to the tokens table, and save the email address in 
sessions#create, then retrieve the corresponding token when 
needed.

However, for the purpose of this tutorial, your token will 
always be found at Token.last.
=end
