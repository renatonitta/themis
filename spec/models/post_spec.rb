require 'spec_helper'

describe Post do
  should_belong_to :author, :class_name => "User", :foreign_key => "user_id"
  should_belong_to :section
  should_validate_presence_of :title, :body, :author, :section
  should_have_an_slugged_id :title
  should_have_default_state :saved
  should_change :from => :saved, :to => :published, :on => :publish
end
