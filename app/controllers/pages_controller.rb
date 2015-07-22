class PagesController < ApplicationController
  def index
    render "login.html.erb", layout: false if current_user.blank?

  end
end
