require 'spec_helper'

describe User do
  should_have_many :posts
  should_validate_presence_of :name
end
