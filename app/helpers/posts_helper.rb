module PostsHelper
  def tags_for(posts)
    posts.map {|p| p.tags.map(&:name) }.flatten.uniq.join(', ')
  end

  def keywords
    @post.present? ? @post.tag_list.to_s : tags_for(@posts)
  end

  def rss_link
    "http://feeds.feedburner.com/" + Themis::Config['name'].delete(' ') + (@section.present? ? @section.name.capitalize : '')
  end
end
