Then /^I should see an input type "([^"]*)" with name "([^"]*)" and value "([^"]*)"$/ do |type, name, value|
  unless value.blank?
    value = "[value='#{value}']"
  end
  locate("input[name='#{name}'][type='#{type}']#{value}")
end

Then /^I should see a form with action "([^"]*)"$/ do |action|
  locate("form[action='#{action}']")
end
