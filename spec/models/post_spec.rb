require 'spec_helper'

describe Post do
  should_belong_to :author, :class_name => "User", :foreign_key => "user_id"
  should_belong_to :section
  should_validate_presence_of :title, :body, :author, :section
  should_have_an_slugged_id :title

  it "should be waiting approval by default" do
    Factory(:post).should be_waiting_approval
  end
end
