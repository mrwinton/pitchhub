class MessagesController < ApplicationController

  before_action :authenticate_user!

  def suggestion

    @suggestion = Suggestion.new

    respond_to do |format|
      # format.html { redirect_to root_path } #for my controller, i wanted it to be JS only
      format.js
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def messages_params
      # Screen the baddies
      params.require(:discourse).permit(:i_scope, :c_scope, :ic_scope, :status, :type, :first_name, :last_name, :comment, :content)
    end

end
