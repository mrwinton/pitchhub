class DisclosureScope
  include Mongoid::Document

  embedded_in :pitch_card_initiator_scope, class_name: "PitchCard", inverse_of: "initiator_scope"
  embedded_in :pitch_card_content_scope, class_name: "PitchCard", inverse_of: "pitch_card_scope"
  embedded_in :comment_author_scope, class_name: "Comment", inverse_of: "author_scope"
  embedded_in :comment_content_scope, class_name: "Comment", inverse_of: "content_scope"

  def is_in_scope
    raise NotImplementedError
  end

  # @return [Object]
  # def user
  #
  #   if true
  #     @test = "test"
  #   end
  #
  # end

end
