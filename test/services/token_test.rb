require 'test_helper'

class OAuthUserTest < ActiveSupport::TestCase
=begin
  Testar no rails console.
  user = User.first
  old_token = user.google_account.oauth_token
  new_token = user.google_fresh_token

  new_token != old_token if user.google_account.oauth_expires < Time.now
=end


  # setup do
  #   @user = User.first
  # end

  # test 'new token is generated if expired' do
  #   @user.google_account.oauth_expires = 1.day.ago  
  #   old_token = @user.google_account.oauth_token
    
  #   @user.fresh_token
  #   new_token = @user.google_account.oauth_token

  #   puts "old_token: #{old_token}"
  #   puts "new_token: #{new_token}"
  #   assert_not_equal old_token, new_token
  # end

  # test 'actual token is retrieved if not expired' do
  #   old_token = @user.google_account.oauth_token
    
  #   @user.fresh_token
  #   new_token = @user.google_account.oauth_token

  #   puts "old_token: #{old_token}"
  #   puts "new_token: #{new_token}"
  #   assert_equal old_token, new_token
  # end
end