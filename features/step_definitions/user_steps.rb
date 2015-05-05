Given /^a user with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  @me ||= FactoryGirl.create(:user, :username => username, :password => password,
                             :password_confirmation => password, :getting_started => false)
  # @me.aspects.create(:name => "Besties")
  # @me.aspects.create(:name => "Unicorns")
  @me.reload
end

Given /^a user with email "([^\"]*)"$/ do |email|
  create_user(:email => email)
end

Given /^a user with username "([^\"]*)"$/ do |username|
  create_user(:email => username + "@" + username + '.' + username, :username => username)
end

Given /^a user named "([^\"]*)" with email "([^\"]*)"$/ do |name, email|
  first, last = name.split
  user = create_user(:email => email, :username => "#{first}_#{last}")
  user.profile.update_attributes!(:first_name => first, :last_name => last) if first
end

Given /^(?:|[tT]hat )?following user[s]?(?: exist[s]?)?:$/ do |table|
  table.hashes.each do |hash|
    if hash.has_key? "username" and hash.has_key? "email"
      step %{a user named "#{hash['username']}" with email "#{hash['email']}"}
    elsif hash.has_key? "username"
      step %{a user with username "#{hash['username']}"}
    elsif hash.has_key? "email"
      step %{a user with email "#{hash['email']}"}
    end
  end
end

And /^I follow the "([^\"]*)" link from the last sent email$/ do |link_text|
  email_text = Devise.mailer.deliveries.first.body.to_s
  email_text = Devise.mailer.deliveries.first.html_part.body.raw_source if email_text.blank?
  doc = Nokogiri("<div>" + email_text + "</div>")

  links = doc.css('a')
  link = links.detect{ |link| link.text == link_text }
  link = links.detect{ |link| link.attributes["href"].value.include?(link_text)} unless link
  path = link.attributes["href"].value
  visit URI::parse(path).request_uri
end

Then /^my "([^\"]*)" should be "([^\"]*)"$/ do |field, value|
  @me.reload.send(field).should == value
end

When /^I fill in the new user form$/ do
  fill_in_new_user_form
end

When /^I click on my name$/ do
  click_link("#{@me.first_name} #{@me.last_name}")
end