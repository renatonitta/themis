xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       "Themis"
   xml.link        root_url
   xml.description "Themis' posts"

   @posts.each do |post|
     xml.item do
       xml.title       post.title
       xml.link        section_post_url(post.section, post)
       xml.guid        section_post_url(post.section, post)
       xml.author      post.author.name
       xml.description post.body
       xml.pubDate     post.created_at
     end
   end
 end
end

