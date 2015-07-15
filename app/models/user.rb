class User < ActiveRecord::Base
  validates :email, :uniqueness => true

  # Associations
  has_many :accounts, :dependent => :destroy

  def active_account
    accounts.first #improve!!! Which account??
  end

  def name
    "#{first_name} #{last_name}"
  end

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end

  def has_twitter?
    accounts.where(provider: 'twitter').any?
  end

  def has_google?
    accounts.where(provider: 'google').any?
  end

=begin
  def has_foursquare?
    accounts.where(provider: 'foursquare').any?
  end
=end

=begin
  def from_omniauth(auth_hash)
    user = find_or_create_by( email: auth_hash['info']['email'],
                              uid: auth_hash['uid'], 
                              provider: auth_hash['provider'])
    user.uid = auth_hash['uid']
    user.provider = auth_hash['provider']
    user.name = auth_hash['info']['name']
    user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls'][user.provider.capitalize]
    user.token = auth_hash['credentials']['token']
    user.refresh_token ||= auth_hash['credentials']['refresh_token'] #is sent only in the first access (consent page)
    user.expires_at = Time.at( auth_hash['credentials']['expires_at'] ).to_datetime
    user.secret = auth_hash['credentials']['secret']
    user.save!
    user
  end
=end


end