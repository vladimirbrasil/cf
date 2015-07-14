Rails.application.config.middleware.use OmniAuth::Builder do
  # provider  :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  # provider  :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  #           scope: 'public_profile', info_fields: 'id,name,link'
  # provider  :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'],
              # scope: 'r_basicprofile',
              # fields: ['id', 'first-name', 'last-name', 'location', 'picture-url', 'public-profile-url']
  provider  :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"], 
            {
              scope: ['email', 'https://www.googleapis.com/auth/gmail.modify'],
              access_type: 'offline',
              image_aspect_ratio: 'square', 
              image_size: 48,
              name: 'google'
            }
end

OmniAuth.config.on_failure = Proc.new do |env|
  SessionsController.action(:auth_failure).call(env)
end