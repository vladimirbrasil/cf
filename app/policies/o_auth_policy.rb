class OAuthPolicy

  def initialize auth
    @auth = auth
    post_initialize(auth)
  end

  def provider
    @auth['provider']
  end

  def uid
    @auth['uid']
  end

  def first_name
    @auth['info']['first_name']
  end

  def last_name
    @auth['info']['last_name']
  end

  def email
    @auth['info']['email']
  end

  def username
    @auth['info']['nickname']
  end

  def location
    @auth['info']['location']
  end

  def url
    @auth['info']['urls'][ @auth['provider'].capitalize ]
  end

  def image_url
    @auth['info']['image']
    # raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  def oauth_token
    @auth['credentials']['token']
  end

  def oauth_expires
    Time.at(@auth['credentials']['expires_at']).to_datetime
  end

  def oauth_refresh_token
    @auth['credentials']['refresh_token']
    #is sent only in the first access (consent page)
  end

  def oauth_secret
    @auth['credentials']['secret']
  end

=begin
  def create_callback account
    # Place any methods you want to trigger on Facebook OAuth creation here.
  end

  def refresh_callback account
    # Place any methods you want to trigger on subsequent Facebook OAuth logins here.
  end
=end

end