class SectionsController < InheritedResources::Base
  before_filter :authenticate_admin!, :only => [:create, :update, :destroy]
end
