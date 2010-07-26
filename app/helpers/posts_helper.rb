module PostsHelper
  def tags_for(posts)
    posts.map {|p| p.tags.map(&:name) }.flatten.uniq.join(', ')
  end

  def keywords
    @post.present? ? @post.tag_list.to_s : tags_for(@posts)
  end

  def rss_link
    "http://feeds.feedburner.com/#{configuration['name']}#{section_name}".delete(' ')
  end

  def rss_title
    "#{configuration['name']}#{section_name}"
  end

  def title
    "#{configuration['name']}#{complement_title}"
  end

  private

  def complement_title
    complement = @section.name unless @section.nil?
    complement = @post.title unless @post.nil?
    " - #{complement}" unless complement.nil?
  end

  def section_name
    @section.present? ? ' ' + @section.name.capitalize : ''
  end
end
