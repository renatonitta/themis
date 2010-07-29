class Admin::SectionsController < InheritedResources::Base
  before_filter :authenticate_admin!
end
