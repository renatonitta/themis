class AdminController < ActionController::Base
  layout 'admin'
  before_filter :authenticate_admin!

  def users
    @users = User.all
  end
end
