require 'test_helper'

class OAuthUserTest < ActiveSupport::TestCase
  setup do
    @email_from_omniauth = @omniauth_response_hash['info']['email']
    @nome_from_omniauth = @omniauth_response_hash['info']['name']
    @uid_from_omniauth = @omniauth_response_hash['uid']
    @provider_from_omniauth = @omniauth_response_hash['provider']
    @oauth = User::OAuthUser.new(@omniauth_response_hash)
  end 

  test "find or create user from omniauth hash response" do
    User.delete_all
    assert_nil User.first, "There shouldn't be an user with email #{@email_from_omniauth} in the database"

    @oauth.first_or_create
    user = user_from_omniauth_hash_response.first

    assert_not_nil user, "OAuthUser failed to create User from omniauth hash"
    assert_equal @email_from_omniauth, user.email
    assert_equal @nome_from_omniauth, user.name

    # nova tentativa de login não cria novo user com mesmo email
    @oauth.first_or_create
    assert_equal 1, user_from_omniauth_hash_response.count, "Falha: nova tentativa de login criou novo user com mesmo email"
  end

  test "find or create account from omniauth hash response" do
    Account.delete_all
    assert_nil Account.first, "There shouldn't be an account with uid #{@uid_from_omniauth} in the database"

    @oauth.first_or_create
    account = account_from_omniauth_hash_response.first

    assert_not_nil account, "OAuthUser failed to create Account from omniauth hash"
    assert_equal @provider_from_omniauth, account.provider
    assert_equal @uid_from_omniauth, account.uid

    # nova tentativa de login não cria novo account com mesmo email
    @oauth.first_or_create
    assert_equal 1, account_from_omniauth_hash_response.count, "Falha: nova tentativa de login criou nova conta com mesmo provider e uid"
  end

  test "account from omniauth belongs to user from omniauth response" do
    User.delete_all
    Account.delete_all

    assert_nil User.first, "There shouldn't be an user with email #{@email_from_omniauth} in the database"
    assert_nil Account.first, "There shouldn't be an account with uid #{@uid_from_omniauth} in the database"

    @oauth.first_or_create
    account = account_from_omniauth_hash_response.first
    assert_not_nil account, "OAuthUser failed to create Account from omniauth hash"

    user = account.user
    assert_not_nil user, "OAuthUser failed to create User from omniauth hash"
    assert_equal @email_from_omniauth, user.email
    assert_equal @nome_from_omniauth, user.name
  end

  def user_from_omniauth_hash_response
    User.where(email: @email_from_omniauth)
  end

  def account_from_omniauth_hash_response
    Account.where(uid: @uid_from_omniauth, provider: @provider_from_omniauth)
  end
end
