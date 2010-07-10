require 'spec_helper'

describe PostsController do
  include Devise::TestHelpers

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
    end

    describe "POST create" do
      it "should create a post for the logged user" do
        post :create, :post => { :title => "Title", :body => "Body" }
        Post.last.user.should == controller.current_user
      end
    end

    describe "PUT update" do
      it "should not update the owner" do
        post = Factory(:post)
        put :update, :id => post.id, :post => {}
        Post.last.user.should_not == controller.current_user
      end
    end
  end

  context "without a logged user" do
    describe "POST create" do
      it "should return 302 as the status code"  do
        post :create
        response.code.should eql("302")
      end
    end

    describe "PUT update" do
      it "should return 302 as the status code"  do
        put :update, :id => 10
        response.code.should eql("302")
      end
    end
  end
end
