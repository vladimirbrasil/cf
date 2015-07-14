class User < ActiveRecord::Base
  class << self
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
      user.secret = auth_hash['credentials']['secret']
      user.save!
      user
    end
  end

end
