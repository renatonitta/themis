class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_save(post)
    expire_cache post
  end

  def after_destroy(post)
    expire_cache post
  end

  protected 
  
  def expire_cache(post)
    expire_page root_path
    (Post.count / Post::PER_PAGE.to_f).ceil.times { |i| expire_page posts_page_path(i + 1) }
    expire_page section_post_path(post.section, post)
    expire_page section_posts_path(post.section)
    (post.section.posts.count / Post::PER_PAGE.to_f).ceil.times { |i| expire_page page_section_posts_path(post.section.id, i + 1) }
  end
end
