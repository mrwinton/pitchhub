module PitchCucumberHelpers

  def stream_posts
    all('.stream_element')
  end

  def stream_element_numbers_content(position)
    find(".stream_element:nth-child(#{position}) .post-content")
  end

end
World(PitchCucumberHelpers)
