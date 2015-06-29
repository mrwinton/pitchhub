class DiscoursesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_discourse, only: [:show]

  # GET /discourse/1
  # GET /discourse/1.json
  def show
    comments = @discourse.comments.select{|comment| can? :read_content, comment}.collect { |comment| comment.to_jq(can? :see_author, comment) }
    render :json => comments.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discourse
      @discourse = Discourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discourse_params
      # Screen the baddies
      params.require(:discourse).permit(:i_scope, :c_scope, :ic_scope, :status, :type, :first_name, :last_name, :comment, :content)
    end

end
