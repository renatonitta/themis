class UsersController < InheritedResources::Base
  layout 'admin'
  before_filter :authenticate_admin!
  
  def create
    create! do |success, failure|
      success.html { redirect_to admin_path }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to admin_path }
    end
  end
end
