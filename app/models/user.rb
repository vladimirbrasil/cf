class User < ActiveRecord::Base
  validates :email, :uniqueness => true
  has_many :accounts, :dependent => :destroy
  validates :email, inclusion: { 
    in: Rails.configuration.x.authorized_emails,
    message: "%{value} não está autorizado." }
  # before_validation :verifiy_email_is_authorized


  def google_account
    accounts.where(provider: 'google').first
  end

  def google_fresh_token
    google_account.fresh_token
  end

 
  # protected
  #   def verifiy_email_is_authorized
  #     raise "Email não autorizado para login." unless Rails.configuration.x.authorized_emails.include?(email)
  #   end  

end
