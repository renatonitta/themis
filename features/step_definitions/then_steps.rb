Then /^I should see (\d+) (\S+)$/ do |count, plural|
  Nokogiri::HTML(page.body).css(".#{plural} > .#{plural.singularize}").size.should == count.to_i
end

Then /^I should see (\d+) rss items$/ do |count|
  Nokogiri::XML(page.body).css("item").size.should == count.to_i
end

Then /^I should see "([^\"]*)" as keyword$/ do |keyword|
  page.should have_xpath("//meta[@name='keywords'][@content='#{keyword}']")
end

Then /^I should see blog description as meta tag$/ do
  page.should have_xpath("//meta[@name='description'][@content='#{Themis::Config['description']}']")
end

Then /^I should see "([^\"]*)" tags as html meta tags$/ do |title|
  post = Post.find_by_title(title)
  Then %{I should see "#{post.tag_list}" as html meta tags}
end

Then /^I should see the search form$/ do
  page.should have_xpath("//form[@action='http://google.com/search']")
  page.should have_xpath("//input[@name='sitesearch'][@type='hidden'][@value='www.example.com']")
  page.should have_xpath("//input[@name='q'][@type='text']")
  page.should have_xpath("//input[@name='commit'][@type='submit'][@value='Search']")
end

Then /^I should see blog information$/ do
  page.should have_content(Themis::Config['name'])
  page.should have_content(Themis::Config['description'])
end

Then /^I should see blog rss$/ do
  page.should have_xpath("//link[@type='application/rss+xml'][@title='#{Themis::Config['name']}'][@href='http://feeds.feedburner.com/#{Themis::Config['name'].delete(" ")}']")
end

Then /^I should see section "([^\"]*)" rss$/ do |section|
  page.should have_xpath("//link[@type='application/rss+xml'][@title='#{Themis::Config['name']} #{section}'][@href='http://feeds.feedburner.com/#{Themis::Config['name'].delete(" ")}#{section.capitalize}']")
end

Then /^I should see blog description on page title$/ do
  with_scope 'title' do
    page.should have_content(Themis::Config['description'])
  end
end
