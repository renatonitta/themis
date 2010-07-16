require 'spec_helper'

describe Section do
  should_validate_presence_of :name
  should_have_many :posts
end
