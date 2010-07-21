require 'spec_helper'

describe PostsHelper do
  context "on #tags_for" do
    it "should return the tag list given some posts" do
      posts = ['ruby, rails', 'rails, blog', 'test'].map { |tag_list| Factory(:post, :tag_list => tag_list) }
      tags_for(posts).should be_eql('ruby, rails, blog, test')
    end
  end
end
