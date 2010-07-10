require 'spec_helper'

describe Post do
  should_belong_to :user
  should_validate_presence_of :title, :body, :user

  it "should be found by the slugged title as an id" do
    post = Factory(:post, :title => "Hello World")
    Post.find(post.id).should == Post.find("hello-world")
  end
end
