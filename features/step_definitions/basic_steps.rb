

Given(/^I (?:visit|am on) the home\s*page$/) do
	visit "/"
end

Then(/^I should see "([^"]+?)" within "([^"]+?)"$/) do |text_to_see, css_selector|
	page.should have_selector(css_selector, :text=>text_to_see)
end