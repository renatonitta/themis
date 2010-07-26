require 'spec_helper'

describe PostsHelper do
  include ApplicationHelper

  context "on #keywords" do
    context "given there is a post" do
      it "should return the post's tags" do
        @post = Factory(:post, :tag_list => 'ruby, ror')
        keywords.should == 'ruby, ror'
      end
    end

    context "given there are some posts" do
      it "should return the posts' tags" do
        @posts = ['ruby, rails', 'rails, blog', 'test'].map { |tag_list| Factory(:post, :tag_list => tag_list) }
        keywords.should == 'ruby, rails, blog, test'
      end
    end
  end

  context "on #rss_link" do
    before :each do
      Themis::Config['name'] = 'Blog Themis'
    end

    context "given there is a section" do
      it "should return section rss link" do
        @section = Factory(:section, :name => 'section')
        rss_link.should == "http://feeds.feedburner.com/BlogThemisSection"
      end
    end

    context "given there is no section" do
      it "should return blog rss link" do
        rss_link.should == "http://feeds.feedburner.com/BlogThemis"
      end
    end
  end

  context "on #rss_title" do
    before :each do
      Themis::Config['name'] = 'Blog Themis'
    end

    context "given there is a section" do
      it "should return section rss link" do
        @section = Factory(:section, :name => 'section')
        rss_title.should == "Blog Themis Section"
      end
    end

    context "given there is no section" do
      it "should return blog rss link" do
        rss_title.should == "Blog Themis"
      end
    end
  end

  context "on #title" do
    before :each do
      Themis::Config['name'] = 'Blog Themis'
    end

    it "should return post title if there is a post" do
      @post = Factory(:post, :title => 'Post')
      title.should == "Blog Themis - Post"
    end

    it "should return section name if there is a section" do
      @section = Factory(:section, :name => 'About')
      title.should == "Blog Themis - About"
    end

    it "should return only the blog name if there is no section and post" do
      title.should == "Blog Themis"
    end
  end
end
