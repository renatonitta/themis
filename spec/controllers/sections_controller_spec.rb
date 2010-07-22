require 'spec_helper'

describe SectionsController do
  should_require_admin_authentication_on_private_actions
end
