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
    expire_page(section_posts_path(record.section))
  end
end
