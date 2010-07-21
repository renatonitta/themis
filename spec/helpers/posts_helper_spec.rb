require 'spec_helper'

describe PostsHelper do
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
end
