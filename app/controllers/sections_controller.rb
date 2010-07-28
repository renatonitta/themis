class SectionsController < InheritedResources::Base
  before_filter :authenticate_admin!, :only => [:create, :update, :destroy, :edit, :new]
  respond_to :js, :only => :destroy

  def create
    create! do |success, failure|
      success.html { redirect_to admin_sections_path }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to admin_sections_path }
    end
  end
end
