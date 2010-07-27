class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def users
    @users = User.all
  end

  def sections
    @sections = Section.all
  end
end
