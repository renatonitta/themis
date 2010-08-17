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
    section = post.section
    [root_path, sitemap_path(:format => :xml), section_path(section, post), section_posts_path(section)].each do |path|
      expire_page path
    end
    Post.each_page { |index| expire_page posts_page_path(index) }
    section.posts.each_page { |index| expire_page page_section_posts_path(section.id, index) }
  end
end

class Object
  def each_page
    (count / Post::PER_PAGE.to_f).ceil.times { |index| yield(index + 1) }
  end
end
