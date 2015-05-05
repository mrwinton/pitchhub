Then(/^"([^"]*)" should be pitch (\d+)$/) do |post_text, position|
  stream_element_numbers_content(position).should have_text(post_text)
end