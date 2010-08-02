class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_update(post)
    expire_cache post
  end

  def after_destroy(post)
    expire_cache post
  end

  protected 
  
  def expire_cache(post)
    [root_path, sitemap_path(:format => :xml), section_post_path(post.section, post), section_posts_path(post.section)].each do |path|
      expire_page path
    end
    pages_count(Post.count).times { |i| expire_page posts_page_path(i + 1) }
    pages_count(post.section.posts.count).times { |i| expire_page page_section_posts_path(post.section.id, i + 1) }
  end

  private

  def pages_count(posts_size)
    (posts_size / Post::PER_PAGE.to_f).ceil
  end
end
