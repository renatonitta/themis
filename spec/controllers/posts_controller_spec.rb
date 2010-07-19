require 'spec_helper'

describe PostsController do
  should_require_authentication_on_private_actions

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
end
