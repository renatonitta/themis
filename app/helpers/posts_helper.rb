module PostsHelper
  def tags_for(posts)
    posts.map {|p| p.tags.map {|t| t.name} }.flatten.uniq.join(', ')
  end
end
