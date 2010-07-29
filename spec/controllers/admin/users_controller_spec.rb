require 'spec_helper'

describe Admin::UsersController do
  should_require_admin_authentication
end
