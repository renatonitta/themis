require 'spec_helper'

describe PostsController do
  should_have_only_public_actions

  let(:section) { Factory :section }

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
end
