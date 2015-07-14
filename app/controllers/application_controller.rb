class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
   
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
   
  helper_method :current_user # ensures that 'current_user' can be called from the views, as well.
end
