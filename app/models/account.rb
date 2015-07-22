class Account < ActiveRecord::Base
  # Account records contain OAuth data from third parties: Facebook, Twitter, Foursquare, and so on.
  validates_uniqueness_of :uid, :scope => :provider
  validates :oauth_refresh_token, presence: true

  belongs_to :user
 
  # Refactor. Token PORO?
  def fresh_token
    Token.new(self).fresh_token
    # refresh! if expired?
    # oauth_token
  end

  # def to_params
  #   {'refresh_token' => oauth_refresh_token,
  #   'client_id' => ENV['GOOGLE_CLIENT_ID'], #Rails.application.secrets.client_id,
  #   'client_secret' => ENV['GOOGLE_SECRET'], #Rails.application.secrets.client_secret,
  #   'grant_type' => 'refresh_token'}
  # end 

  # def request_token_from_google
  #   url = URI("https://accounts.google.com/o/oauth2/token")
  #   Net::HTTP.post_form(url, self.to_params)
  # end
 
  # def refresh!
  #   response = request_token_from_google
  #   data = JSON.parse(response.body)
  #   puts "teste: #{data}"
  #   update_attributes(
  #     oauth_token: data['access_token'],
  #     oauth_expires: Time.now + (data['expires_in'].to_i).seconds
  #   )
  # end
 
  # def expired?
  #   oauth_expires < Time.now
  # end

end
