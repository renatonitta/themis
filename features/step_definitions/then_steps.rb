Then /^I should see (\d+) (\S+)$/ do |count, plural|
  Nokogiri::HTML(page.body).css(".#{plural} > .#{plural.singularize}").size.should == count.to_i
end

Then /^I should see (\d+) rss items$/ do |count|
  Nokogiri::XML(page.body).css("item").size.should == count.to_i
end

Then /^I should see page's keywords$/ do
  page.should have_xpath("//meta[@name='keywords']")
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
