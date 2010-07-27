require 'spec_helper'

describe AdminController do
  include Devise::TestHelpers

  context "with a logged admin" do
    before :each do
      sign_in Factory(:admin)
    end

    describe "responding to GET users" do
      it "should list users" do
        3.times { Factory(:user) }
        get :users
        assigns(:users).should == User.all
      end
    end
  end

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
    end

    describe "responding to GET users" do
      it "should return 302 as the status code" do
        get :users
        response.code.should eql("302")
      end
    end
  end
end
