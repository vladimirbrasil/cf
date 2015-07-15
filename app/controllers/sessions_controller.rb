=begin
class SessionsController < ApplicationController
  def create
    begin
      # flash[:success] = request.env['omniauth.auth']
      @user = User.from_omniauth(request.env['omniauth.auth'])

      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
  end
end
=end


class SessionsController < ApplicationController

  def new
  end

  def create
    # flash[:success] = request.env['omniauth.auth']


    # # begin
      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create

      @account = oauth.account
      @user = @account.user
      session[:user_id] = oauth.user.id
      flash[:success] = "Welcome, #{@user.name}!"
    # # rescue
    #   # flash[:warning] = "There was an error while trying to authenticate you..."
    # # end
    redirect_to root_path


  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

  def auth_failure
    redirect_to root_path
  end

end