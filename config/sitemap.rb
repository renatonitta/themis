# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = Themis::Config["host"]

def pages_count(posts_size)
  (posts_size / Post::PER_PAGE.to_f).ceil
end

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Usage: sitemap.add path, options
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly', 
  #           :lastmod => Time.now, :host => default_host

  pages_count(Post.count).times { |i| sitemap.add posts_page_path(i + 1) }

  Post.approved.all.each do |post|
    sitemap.add section_post_path(post.section, post)
  end

  Section.all.each do |section|
    sitemap.add section_posts_path(section)
    pages_count(section.posts.count).times { |i| sitemap.add page_section_posts_path(section, i + 1) }
  end

  File.open("public/robots.txt", 'w') {|f| f.write("Sitemap: #{SitemapGenerator::Sitemap.default_host}/sitemap1.xml.gz") }
end
