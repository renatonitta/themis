require 'spec_helper'

describe User do
  should_have_many :posts
  should_validate_presence_of :name

  it "should accept a name on creation" do
    User.new(:name => "Diego").name.should eql("Diego")
  end

  context "on posts#editable" do
    let(:user) { Factory :user }

    before :each do
      Factory :post
      Factory :post, :author => user
    end

    context "user not approver" do
      it "should return only posts related to user" do
        user.posts_editable.size.should == 1
      end 
    end 

    context "user approver" do
      it "should return all posts" do
        Factory(:approver_user).posts_editable.size.should == 2
      end
    end
  end
end
