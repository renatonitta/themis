require 'spec_helper'

describe PostsController do
  include Devise::TestHelpers

  describe "POST create" do
    context "with a logged user" do
      before :each do
        sign_in Factory(:user)
      end

      it "should create a post for the logged user" do
        post :create, :post => { :title => "Title", :body => "Body" }
        Post.last.user.should == controller.current_user
      end
    end

    context "without a logged user" do
      it "should return 302 as the status code"  do
        post :create
        response.code.should eql("302")
      end
    end
  end
end
