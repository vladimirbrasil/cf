class User::OAuthUser
  extend ActiveSupport::Concern

  attr_reader :user, :account

  def initialize auth_hash
    provider = auth_hash['provider']
    @policy       = "OAuthPolicy::#{provider.classify}".constantize.new(auth_hash)
    # FacebookPolicy | GooglePolicy | TwitterPolicy |etc.
  end

  def first_or_create
    @user = user_first_or_create
    @account = account_first_or_create(@user)

    @user
  end

  private

  def user_first_or_create
    User.where(email: @policy.email).first_or_create do |user|
      user.name = @policy.name
    end    
  end
 
  def account_first_or_create(user)
    user.accounts.where(uid: @policy.uid, provider: @policy.provider).first_or_create do |account|
      account.oauth_token           = @policy.oauth_token
      account.oauth_refresh_token   ||= @policy.oauth_refresh_token
      account.oauth_expires         = @policy.oauth_expires
      account.image_url             = @policy.image_url
    end    
  end 

end