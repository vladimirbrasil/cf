class Account < ActiveRecord::Base
  validates_uniqueness_of :uid, :scope => :provider
  # Account records contain OAuth data from third parties: Facebook, Twitter, Foursquare, and so on.

  # Associations
  belongs_to :user
end