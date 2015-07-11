class CommentsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!
  before_action :set_pitch_card, only: [:index, :new, :create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  # GET /pitch_cards/1/comments
  # GET /pitch_cards/1/comments.json
  def index
    # Retrieve the comments (suggestions included) that the current user is permitted to see
    permitted_comments = @pitch_card.comments.select{|comment| can? :read_content, comment}
    # Sort most recent first
    sorted_permitted_comments = permitted_comments.sort_by {|obj| -obj.created_at.to_f}
    # Paginate the permitted_comments according to the params[:page] paramated (if set)
    @discourses = Kaminari.paginate_array(sorted_permitted_comments).page(params[:page]).per(10)
    # TODO for each discourse get it's children comments (if any)

    respond_to do |format|
      format.js
    end
  end

  # GET /pitch_cards/1/comments/new
  def new
    @comment = Comment.new
    @comment.comment = params[:content]
    @pitch_point_id = params[:pitch_point_id]
    @pitch_point_name = params[:pitch_point_name]
    respond_to do |format|
      format.js
    end
  end

  # POST /pitch_cards/1/comments
  # POST /pitch_cards/1/comments.json
  def create
    # Create the suggestion in the pitch card's comments relation
    @comment = @pitch_card.comments.build(comment_params, Comment)
    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @comment.inject_scopes(@scopes)
    # Set the current user as the Comment's initiator
    @comment.author = current_user
    @comment.message_type = :root
    @comment.author_name = current_user.first_name + " " + current_user.last_name

    respond_to do |format|
      if @comment.save
        current_user.collab_pitch_cards << @pitch_card
        flash.now[:notice] = 'Comment was successfully created.'
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
      else
        flash.now[:alert] = pluralize(@comment.errors.count, "error") + ' found, please fix before submitting'
        format.html { redirect_to :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pitch_cards/1/comments/1
  # PATCH/PUT /pitch_cards/1/comments/1.json
  def update
    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @comment.i_scope = params[:comment][:i_scope]
    @comment.c_scope = params[:comment][:c_scope]
    @comment.inject_scopes(@scopes)

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to :back, notice: 'Comment was successfully updated.' }
      else
        flash.now[:alert] = pluralize(@comment.errors.count, "error") + ' found, please fix before submitting'
        format.html { redirect_to :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitch_cards/1/comments/1
  # DELETE /pitch_cards/1/comments/1.json
  def destroy
    authorize! :manage, @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_pitch_card
    @pitch_card = PitchCard.find(params[:pitch_card_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    # Screen the baddies
    params.require(:comment).permit(:pitch_point_id, :pitch_point_name, :comment, :i_scope, :c_scope, :ic_scope, :type, :first_name, :last_name)
  end

end
