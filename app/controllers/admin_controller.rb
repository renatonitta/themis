class AdminController < ActionController::Base
  before_filter :authenticate_admin!

  def users
    @users = User.all
  end
end
