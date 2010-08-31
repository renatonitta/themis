require 'spec_helper'

describe Panel::PostsController do
  include Devise::TestHelpers

  should_require_authentication

  let(:post_object) { Factory :post }

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
    end

    describe "POST create" do
      it "should create a post for the logged user" do
        post :create, :post =>  { :title => "Title", :body => "Body", :section_id => post_object.section.id }
        Post.first.author.should == controller.current_user
      end

      it "should not expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        post :create, :post =>  { :title => "Title", :body => "Body", :section_id => post_object.section.id }
        File.exist?(file_name).should be_true
      end

      it "should not expire the section posts page cache" do
        path = "#{CACHE_PATH}/sections/#{post_object.section.id}/posts/pages"
        file_name = "#{path}/1.html"
        FileUtils.mkdir_p path
        File.open file_name, 'w'
        post :create, :post =>  { :title => "Title", :body => "Body", :section_id => post_object.section.id }
        File.exist?(file_name).should be_true
      end
    end

    describe "PUT update" do
      it "should not update the owner" do
        put :update, :id => post_object.id, :post => { :title => "Title", :body => "Body" }
        Post.last.author.should_not == controller.current_user
      end

      it "should expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        put :update, :id => post_object.id, :post => { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_false
      end

      it "should expire the sitemap.xml" do
        file_name = "#{CACHE_PATH}/sitemap.xml"
        File.open file_name, 'w'
        put :update, :id => post_object.id, :post => { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_false
      end

      it "should expire the post page cache" do
        path = "#{CACHE_PATH}/sections/#{post_object.section.id}/posts/pages"
        file_name = "#{path}/1.html"
        FileUtils.mkdir_p path
        File.open file_name, 'w'
        put :update, :id => post_object.id, :post => { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_false
      end
    end

    describe "DELETE destroy" do
      it "should delete a post" do
        delete :destroy, :id => post_object.id 
        Post.find_by_id(post_object.id).should be_nil
      end

      it "should expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        delete :destroy, :id => post_object.id
        File.exist?(file_name).should be_false
      end
    end

    describe "PUT approve" do
      it "should return 302 as the status code" do
        put :approve, :id => 5
        response.code.should eql('302')
      end
    end

    describe "GET index" do
      it "should return 200 as the status code" do
        get :index
        response.code.should eql('200')
      end

      it "should return a list of posts" do
        post_from_another_user = Factory(:post)
        get :index
        assigns(:posts) == controller.current_user.posts
      end
    end
  end

  context "with a logged approver user" do
    before :each do
      sign_in Factory(:approver_user)
    end

    describe "PUT approve" do
      it "should approve a post" do
        put :approve, :id => post_object.id
        Post.find(post_object.id).should be_approved
      end

      it "should expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        put :approve, :id => post_object.id
        File.exist?("#{CACHE_PATH}/index.html").should be_false
      end
    end

    describe "POST preview" do
      it "should return an html" do
        post :preview, :data => "h1. Title"
        response.body.should == "<h1>Title</h1>"
      end
    end
  end
end
