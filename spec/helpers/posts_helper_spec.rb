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
        keywords.should be_eql('ruby, rails, blog, test')
      end
    end
  end
end
