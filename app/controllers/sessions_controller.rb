class SessionsController < ApplicationController

  def new
  end

  def create
    # raise auth_hash.to_yaml
    oauthuser = User::OAuthUser.new(auth_hash)
    
    user = oauthuser.first_or_create

    if user.valid?
      session[:user_id] = user.id
      flash[:success] = "Bem vindo, #{user.name}!"
    else
      flash[:error] = user.errors.full_messages.join(' | ')
      # flash[:warning] = "Houve um erro ao tentar autenticá-lo... #{params[:message]}"
      # redirect_to login_path, login_errors: user.errors
    end
    redirect_to root_path
  end

  # def create
  #   # flash[:success] = request.env['omniauth.auth']
  #   begin
  #     oauthuser = User::OAuthUser.new(auth_hash, current_user)
  #     oauthuser.first_or_create
  #     @user = oauthuser.account.user
  #     # self.current_user = @user
  #     session[:user_id] = @user.id
  #     flash[:success] = "Bem vindo, #{@user.name}!"
  #   rescue
  #     flash[:warning] = "Houve um erro ao tentar autenticá-lo... #{params[:message]}"
  #   end
  #   redirect_to root_path
  # end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'Até logo!'
    end
    redirect_to root_path
  end

  protected
  
  def auth_hash
    request.env["omniauth.auth"]
  end

  def auth_failure
    redirect_to root_path
  end

end

