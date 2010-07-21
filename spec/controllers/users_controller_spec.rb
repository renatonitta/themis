require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  context "with a logged Admin" do
    before :each do
      sign_in Factory(:admin)
    end

    describe "responding to POST create" do
      it "should create an user" do
        post :create, :user => { :name => "Mike Tyson", :email => "mike@tyson.com", :password => "mike123" }   
        User.find_by_email("mike@tyson.com").should_not be_nil
      end
    end
  end
end
