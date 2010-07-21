class UsersController < InheritedResources::Base
  before_filter :authenticate_admin!
end
