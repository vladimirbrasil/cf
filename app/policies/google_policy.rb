class GooglePolicy < OAuthPolicy

  def post_initialize auth
    @auth = auth
  end

  def create_callback account
    # Place any methods you want to trigger on Google OAuth creation here.
  end

  def refresh_callback account
    # Place any methods you want to trigger on subsequent Google OAuth logins here.
  end

end