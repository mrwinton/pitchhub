And /^I submit the form$/ do
  find("input[type='submit']").click
end

And /^I click on selector "([^"]*)"$/ do |selector|
  find(selector).click
end
And /^I click on the first selector "([^"]*)"$/ do |selector|
  find(selector, match: :first).click
end

And /^I confirm the alert$/ do
  page.driver.browser.switch_to.alert.accept
end

And /^I reject the alert$/ do
  page.driver.browser.switch_to.alert.dismiss
end

When /^I press the first "([^"]*)"(?: within "([^"]*)")?$/ do |link_selector, within_selector|
  with_scope(within_selector) do
    current_scope.find(link_selector, match: :first).click
  end
end

When /^I press the ([\d])(?:nd|rd|st|th) "([^\"]*)"(?: within "([^\"]*)")?$/ do |number, link_selector, within_selector|
  with_scope(within_selector) do
    current_scope.find(:css, link_selector+":nth-child(#{number})").click
  end
end

Then /^(?:|I )should see a "([^\"]*)"(?: within "([^\"]*)")?$/ do |selector, scope_selector|
  with_scope(scope_selector) do
    current_scope.should have_css selector
  end
end

Then /^(?:|I )should not see a "([^\"]*)"(?: within "([^\"]*)")?$/ do |selector, scope_selector|
  with_scope(scope_selector) do
    current_scope.should page.has_no_css?(selector, :visible => true)
  end
end

Then /^page should (not )?have "([^\"]*)"$/ do |negate, selector|
  page.should ( negate ? (page.has_no_css?(selector)) : (page.has_css?(selector)) )
end

When /^I have turned off jQuery effects$/ do
  page.execute_script("$.fx.off = true")
end

When /^I search for "([^\"]*)"$/ do |search_term|
  fill_in "q", :with => search_term
  find_field("q").native.send_keys(:enter)
  have_text(search_term)
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should be filled with "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    field_value = field_value.first if field_value.is_a? Array
    field_value.should == value
  end
end

Then 'I should see an image attached to the post' do
  step %{I should see a "img" within ".stream_element div.photo_attachments"}
end

Then 'I press the attached image' do
  step %{I press the 1st "img" within ".stream_element div.photo_attachments"}
end

And "I wait for the popovers to appear" do
  page.should have_selector(".popover", count: 3)
end

And /^I click close on all the popovers$/ do
  page.execute_script("$('.popover .close').click();")
  page.should_not have_selector(".popover .close")
end

Then /^I should see a flash message indicating success$/ do
  flash_message_success?.should be true
end

Then /^I should see a flash message indicating failure$/ do
  flash_message_failure?.should be true
end

Then /^I should see a flash message with a warning$/ do
  flash_message_alert?.should be true
end

Then /^I should see a flash message containing "(.+)"$/ do |text|
  flash_message_containing? text
end

When /^I focus the "([^"]+)" field$/ do |field|
  find_field(field).click
end

Then(/^I should have a validation error on "(.*?)"$/) do |field_list|
  check_fields_validation_error field_list
end

When /^(.*) in the header$/ do |action|
  within('header') do
    step action
  end
end