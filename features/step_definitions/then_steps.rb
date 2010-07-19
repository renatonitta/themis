Then /^I should see (\d+) posts$/ do |count|
  Nokogiri::HTML(page.body).css(".posts > .post").size.should == count.to_i
end

Then /^I wait for disqus$/ do
  wait_for do 
    begin
      locate ".dsq-post-area"
      false
    rescue Exception
      true
    end
  end
end
