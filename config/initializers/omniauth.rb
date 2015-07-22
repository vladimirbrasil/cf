Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  # provider  :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  # provider  :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  #           scope: 'public_profile', info_fields: 'id,name,link'
  # provider  :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'],
              # scope: 'r_basicprofile',
              # fields: ['id', 'first-name', 'last-name', 'location', 'picture-url', 'public-profile-url']
  provider  :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"], 
            {
              scope: ['email',  'profile',
                      'gmail.modify',  #initiaded with 'https://www.googleapis.com/auth/' only the final part is fine
                      #'gmail.compose',
                      'https://mail.google.com/mail/feed/atom',
                      'calendar',
                      'https://www.google.com/m8/feeds', #contacts
                      'drive.file',
                      'mapsengine',
                      'coordinate',
                      'userinfo.email',
                      'userinfo.profile',
                      'https://picasaweb.google.com/data',
                      'prediction',             #https://cloud.google.com/prediction/docs/hello_world
                      'devstorage.read_write',  #https://cloud.google.com/prediction/docs/developer-guide
                      'datastore'             #
                      #'taskqueue'
                    ],
              #prompt: 'select_account', #if user has multiple accounts it's better to promp always
              #login_hint: 'vladimir.brasil@gmail.com', #pre-fill login os select correct account in multiple accounts
              access_type: 'offline',
              image_aspect_ratio: 'square', 
              image_size: 48,
              name: 'google'
            }
end

OmniAuth.config.on_failure = Proc.new do |env|
  SessionsController.action(:auth_failure).call(env)
end

OmniAuth.config.logger = Rails.logger