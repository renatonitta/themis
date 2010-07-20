require 'spec_helper'

describe PostsController do
  include Devise::TestHelpers

  let(:section) { Factory :section }

  context "without a logged user" do
    describe "GET index" do
      it "should return 200 as the status code" do
        get :index, :section_id => section.id
        response.code.should eql("200")
      end
    end

    describe "GET show" do
      let(:post) { Factory :post, :section => section }

      it "should assign the post to @post" do
        get :show, :section_id => section.id, :id => post.id
        assigns(:post).should == post
      end

      it "should assign all sections as @sections" do
        2.times { Factory :section }
        get :show, :section_id => section.id, :id => post.id
        assigns(:sections).should == Section.all
      end
    end

    describe "GET all" do
      it "should return all the sections" do
        2.times { Factory :section }
        get :all
        assigns(:sections).size.should == Section.count
      end

      it "should return all the posts" do
        2.times { Factory :post }
        get :all
        assigns(:posts).size.should == Post.count
      end
    end

    describe "GET by_tag" do
      it "should return all the posts with the specific tag" do
        Factory :post, :tag_list => 'tag1, tag2'
        Factory :post, :tag_list => 'tag2'
        Factory :post, :tag_list => 'tag3'
        get :by_tag, :id => 'tag2'
        assigns(:posts).size.should == 2
      end
    end

    describe "POST create" do
      it "should return 302 as the status code"  do
        post :create, :section_id => section.id
        response.code.should eql("302")
      end
    end

    describe "PUT update" do
      it "should return 302 as the status code"  do
        put :update, :section_id => section.id, :id => 10
        response.code.should eql("302")
      end
    end

    describe "DELETE destroy" do
      it "should return 302 as the status code" do
        delete :destroy, :section_id => section.id, :id => 20
        response.code.should eql("302")
      end
    end
  end

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
    end

    describe "POST create" do
      it "should create a post for the logged user" do
        post :create, :section_id => section.id, :post =>  { :title => "Title", :body => "Body" }
        Post.last.author.should == controller.current_user
      end

      it "should create a post for specified section" do
        post :create, :section_id => section.id, :post =>  { :title => "Title", :body => "Body" }
        Post.last.section.should eql(section)
      end
    end

    describe "PUT update" do
      it "should not update the owner" do
        post = Factory(:post, :section => section)
        put :update, :section_id => section.id, :id => post.id, :post => { :title => "Title", :body => "Body" }
        Post.last.author.should_not == controller.current_user
      end
    end
  end
end
