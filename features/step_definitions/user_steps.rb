When /^I fill the new user form$/ do
  When %{I fill in "Name" with "Ricardo"}
  When %{I fill in "Email" with "ricardo@gonow.com.br"}
  When %{I fill in "Password" with "password"}
  When %{I fill in "Password confirmation" with "password"}
end
