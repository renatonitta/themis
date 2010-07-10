Then /^I should see (\d+) posts$/ do |count|
  Nokogiri::HTML(page.body).css(".posts > .post").size.should == count.to_i
end
