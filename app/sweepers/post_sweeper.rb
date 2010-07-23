class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_save(record)
    expire_cache record
  end

  def after_destroy(record)
    expire_cache record
  end

  protected 
  
  def expire_cache(record)
    expire_page(root_path)
    (Post.all.size / Post::PER_PAGE.to_f).ceil.times {|i| expire_page(posts_page_path(i+1))}
    expire_page(section_post_path(record.section.id, record.id))
    expire_page(section_posts_path(record.section.id))
    (record.section.posts.size / Post::PER_PAGE.to_f).ceil.times {|i| expire_page(section_posts_page_path(record.section.id, i+1))}
  end
end
