Given /^the Google Analytics code is "(.*)"$/ do |tracker_id|
  Themis::Config['google_analytics']['tracker_id'] = tracker_id   
end
