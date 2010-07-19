def should_have_an_slugged_id(name)
  it "should be found by the slugged #{name} as an id" do
    clazz = subject.class
    object = Factory(clazz.to_s.underscore, name => "Hello World")
    clazz.find(object.id).should == clazz.find("hello-world")
  end
end

def should_require_authentication_on_private_actions
  include Devise::TestHelpers

  context "without a logged user" do
    describe "GET index" do
      it "should return 200 as the status code" do
        get :index
        response.code.should eql("200")
      end
    end

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

    describe "DELETE destroy" do
      it "should return 302 as the status code" do
        delete :destroy, :id => 20
        response.code.should eql("302")
      end
    end
  end
end
