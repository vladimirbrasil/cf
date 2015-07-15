class OAuthUser

  attr_reader :provider, :user, :account

  def initialize creds, user = nil
    @auth         = creds
    @user         = user
    @provider     = @auth['provider']
    @policy       = "#{@provider}_policy".classify.constantize.new(@auth)
    # FacebookPolicy | GooglePolicy | TwitterPolicy |etc.
  end

  def login_or_create
    @user = User.where(email: @policy.email).first_or_create do |user|
      user.first_name = @policy.first_name
      user.last_name =  @policy.last_name
    end

    @account = @user.accounts.where(uid: @policy.uid, provider: @provider).first_or_create do |account|
      account.oauth_token           = @policy.oauth_token
      account.oauth_refresh_token   = @policy.oauth_refresh_token
      account.oauth_expires         = @policy.oauth_expires
      account.oauth_secret          = @policy.oauth_secret
      account.username              = @policy.username
      account.location              = @policy.location
      account.image_url             = @policy.image_url
      account.url                   = @policy.url
    end
  end

=begin
  def logged_in?
    @user.present?
  end


  # private

    def login
      @account = Account.where(provider: @provider, uid: @policy.uid).first
      if @account.present?
        refresh_tokens
        @user = @account.user
        @policy.refresh_callback(@account)
      else
        false
      end
    end

    def account_already_exists?
      @user.accounts.exists?(provider: @provider, uid: @policy.uid)
    end

    def create_new_account
      create_new_user if @user.nil?

      unless account_already_exists?
        @account = @user.accounts.create!(
          :provider      => @provider,
          :uid           => @policy.uid,
          :oauth_token   => @policy.oauth_token,
          :oauth_expires => @policy.oauth_expires,
          :oauth_secret  => @policy.oauth_secret,
          :username      => @policy.username
        )

        @policy.create_callback(@account)
      end
    end

    def create_new_user
      @user = User.create!(
        :first_name => @policy.first_name,
        :last_name  => @policy.last_name,
        :email      => @policy.email,
        # :picture    => image
      )
    end

    # def image
    #   image = open(URI.parse(@policy.image_url), :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
    #   def image.original_filename; base_uri.path.split('/').last; end
    #   image
    # end

    def refresh_tokens
      @account.update_attributes(
        :oauth_token   => @policy.oauth_token,
        :oauth_expires => @policy.oauth_expires,
        :oauth_secret  => @policy.oauth_secret
      )
    end
=end


end