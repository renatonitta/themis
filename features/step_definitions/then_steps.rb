Then /^I should see (\d+) (\S+)$/ do |count, plural|
  Nokogiri::HTML(page.body).css(".#{plural} > .#{plural.singularize}").size.should == count.to_i
end

Then /^I should see (\d+) rss items$/ do |count|
  Nokogiri::XML(page.body).css("item").size.should == count.to_i
end
