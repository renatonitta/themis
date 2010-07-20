When /^I visit new post$/ do
  visit new_section_post_path(Section.last)
end

Then /^I should see "([^\"]*)" as html meta tags$/ do |tags|
  locate("meta[name='keywords'][content='#{tags}']")
end

Then /^I should see "([^\"]*)" tags as html meta tags$/ do |title|
  post = Post.find_by_title(title)
  locate("meta[name='keywords'][content='#{post.tag_list}']")
end
