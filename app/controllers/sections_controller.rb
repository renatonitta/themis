class SectionsController < InheritedResources::Base
  before_filter :authenticate_admin!, :only => [:create, :update, :destroy, :edit, :new]
  respond_to :js
  def create
    create! { admin_sections_path }
  end

  def update
    update! { admin_sections_path }
  end
end
