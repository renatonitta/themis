Then /^I should see an input type "([^"]*)" with name "([^"]*)" and value "([^"]*)"$/ do |type, name, value|
  unless value.blank?
    value = "[value='#{value}']"
  end
  locate("input[name='#{name}'][type='#{type}']#{value}")
end

Then /^I should see a form with action "([^"]*)"$/ do |action|
  locate("form[action='#{action}']")
end

Then /^I should see the search form$/ do
  Then %{I should see a form with action "http://google.com/search"}
  Then %{I should see an input type "hidden" with name "sitesearch" and value "www.example.com"}
  Then %{I should see an input type "text" with name "q" and value ""}
  Then %{I should see an input type "submit" with name "commit" and value "Search"}
end

