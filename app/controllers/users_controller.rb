class UsersController < InheritedResources::Base
  layout 'admin'
  before_filter :authenticate_admin!
end
