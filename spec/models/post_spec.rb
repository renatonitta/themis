require 'spec_helper'

describe Post do
  should_belong_to :user
  should_validate_presence_of :title, :body, :user
end
