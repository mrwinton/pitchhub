class CommentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_comment.subject
  #
  def new_suggestion(comment)
    @comment = comment
    @pitch_card = @comment.pitch_card
    @user = @pitch_card.initiator.first_name

    mail to: @pitch_card.initiator.email, 
         subject: "New Suggestion on your pitch card"
  end

  def new_comment(comment)
    @comment = comment
    @pitch_card = @comment.pitch_card
    @user = @comment.author.first_name

    mail to: @comment.author.email, 
         subject: "New Comment on your suggestion"
  end

end
