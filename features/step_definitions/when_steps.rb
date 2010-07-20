When /^I visit "([^"]*)"$/ do |path|
  visit path
end

When /^I visit new post$/ do
  visit new_section_post_path(Section.last)
end

When /^I fill the new user form$/ do
  When %{I fill in "Name" with "Ricardo"}
  When %{I fill in "Email" with "ricardo@gonow.com.br"}
  When %{I fill in "Password" with "password"}
  When %{I fill in "Password confirmation" with "password"}
end
