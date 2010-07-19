class SectionsController < InheritedResources::Base
  before_filter :authenticate_user!, :only => [:create, :update, :destroy]
end
