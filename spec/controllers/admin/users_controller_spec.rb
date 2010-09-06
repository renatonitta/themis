require 'spec_helper'

describe Admin::UsersController do
  should_require_admin_authentication

  context "logged admin" do
    before :each do
      controller.stub!(:authenticate_admin!)
    end

    describe "POST create" do
      it "should redirect to index" do
        post :create, :user => {:name => 'Test', :email => 'test@mail.com', :password => '123456', :password_confirmation => '123456'}
        response.should redirect_to(admin_users_path)
      end
    end

    describe "PUT update" do
      it "should redirect to index" do
        put :update, :id => Factory(:user).id
        response.should redirect_to(admin_users_path)
      end
    end
  end
end
