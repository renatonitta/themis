require 'spec_helper'

describe PostsController do
  include Devise::TestHelpers

  let(:section) { Factory :section }

  context "without a logged user" do
    describe "GET index" do
      [:html, :rss].each do |format|
        it "should return 200 as the status code with #{format} format" do
          get :index, :section_id => section.id, :format => format
          response.code.should eql("200")
        end

        it "should return only approved posts" do
          3.times { Factory :post, :section => section }
          2.times { Factory :approved_post, :section => section }
          get :index, :section_id => section.id, :format => format
          assigns(:posts).size.should == section.posts.approved.size
        end

        it "should paginate the posts" do
          (Post::PER_PAGE + 1).times { Factory :approved_post, :section => section }
          get :index, :section_id => section.id, :page => 2
          assigns(:posts).size.should == 1
        end

        it "should order post from newest to oldest" do
          5.times { Factory :approved_post, :section => section }
          get :index, :section_id => section.id, :format => format
          assigns(:posts).first.created_at.should > assigns(:posts).last.created_at
        end
      end

      it "should cache the page" do
        clear_cache
        (Post::PER_PAGE + 1).times { Factory :approved_post, :section => section }
        get :index, :section_id => section.id, :page => 2
        File.exist?("#{CACHE_PATH}/sections/#{section.id}/posts/pages/2.html").should be_true
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

      it "should cache the page" do
        clear_cache
        get :show, :section_id => section.id, :id => post.id
        File.exist?("#{CACHE_PATH}/sections/#{section.id}/posts/#{post.id}.html").should be_true
      end
    end

    describe "GET all" do
      it "should return all the sections" do
        2.times { Factory :section }
        get :all
        assigns(:sections).size.should == Section.count
      end

      it "should return all the approved posts" do
        Factory :post
        2.times { Factory :approved_post }
        get :all
        assigns(:posts).size.should == Post.approved.size
      end

      it "should cache the page" do
        clear_cache
        get :all
        File.exist?("#{CACHE_PATH}/index.html").should be_true
      end
    end

    describe "GET by_tag" do
      it "should return all the approved posts with the specific tag" do
        Factory :post, :tag_list => 'tag1'
        2.times {|i| Factory :approved_post, :tag_list => "tag#{i}" }
        get :by_tag, :tag => 'tag1'
        assigns(:posts).size.should == 1
      end

      it "should return all approved posts with the specific tag paginated" do
        (Post::PER_PAGE + 1).times { Factory :approved_post, :tag_list => 'tag'}
        get :by_tag, :tag => 'tag', :page => 2
        assigns(:posts).size.should == 1 
      end

      it "should assign the tag to @tag" do
        get :by_tag, :tag => "cool"
        assigns(:tag).should eql("cool")
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

    describe "PUT approve" do
      it "should return 302 as the status code" do
        put :approve, :section_id => section.id, :id => 30
        response.code.should eql("302")
      end
    end
  end

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
      @post = Factory :post, :section => section
    end

    describe "POST create" do
      it "should create a post for the logged user" do
        post :create, :section_id => section.id, :post =>  { :title => "Title", :body => "Body" }
        Post.first.author.should == controller.current_user
      end

      it "should create a post for specified section" do
        post :create, :section_id => section.id, :post =>  { :title => "Title", :body => "Body" }
        Post.last.section.should eql(section)
      end

      it "should not expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        post :create, :section_id => section.id, :post =>  { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_true
      end

      it "should not expire the section posts page cache" do
        path = "#{CACHE_PATH}/sections/#{section.id}/posts/pages"
        file_name = "#{path}/1.html"
        FileUtils.mkdir_p path
        File.open file_name, 'w'
        post :create, :section_id => section.id, :post =>  { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_true
      end
    end

    describe "PUT update" do
      it "should not update the owner" do
        put :update, :section_id => section.id, :id => @post.id, :post => { :title => "Title", :body => "Body" }
        Post.last.author.should_not == controller.current_user
      end

      it "should expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        put :update, :section_id => section.id, :id => @post.id, :post => { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_false
      end

      it "should expire the sitemap.xml" do
        file_name = "#{CACHE_PATH}/sitemap.xml"
        File.open file_name, 'w'
        put :update, :section_id => section.id, :id => @post.id, :post => { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_false
      end

      it "should expire the post page cache" do
        path = "#{CACHE_PATH}/sections/#{section.id}/posts/pages"
        file_name = "#{path}/1.html"
        FileUtils.mkdir_p path
        File.open file_name, 'w'
        put :update, :section_id => section.id, :id => @post.id, :post => { :title => "Title", :body => "Body" }
        File.exist?(file_name).should be_false
      end
    end

    describe "DELETE destroy" do
      it "should delete a post" do
        delete :destroy, :section_id => section.id, :id => @post.id 
        Post.find_by_id(@post.id).should be_nil
      end

      it "should expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        delete :destroy, :section_id => section.id, :id => @post.id
        File.exist?(file_name).should be_false
      end
    end

    describe "PUT approve" do
      it "return 302 as the status code" do
        put :approve, :section_id => section.id, :id => 5
        response.code.should eql('302')
      end
    end
  end

  context "with a logged approver user" do
    before :each do
      sign_in Factory(:approver_user)
      @post = Factory :post
    end

    describe "PUT approve" do
      it "should approve a post" do
        put :approve, :section_id => section.id, :id => @post.id
        Post.find(@post.id).should be_approved
      end

      it "should expire the blog index page cache" do
        file_name = "#{CACHE_PATH}/index.html"
        File.open file_name, 'w'
        put :approve, :section_id => section.id, :id => @post.id
        File.exist?("#{CACHE_PATH}/index.html").should be_false
      end
    end
  end
end
