Then /^I should see (\d+) (.*)/ do |count, plural|
  Nokogiri::HTML(page.body).css(".#{plural} > .#{plural.singularize}").size.should == count.to_i
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
