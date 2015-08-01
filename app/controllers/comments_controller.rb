class CommentsController < ApplicationController
  include ActionView::Helpers::TextHelper
  include SecretSharingController
  before_action :authenticate_user!
  before_action :set_pitch_card, only: [:index, :new, :create, :update, :destroy, :initiator_scope, :accept]
  before_action :set_comment, only: [:update, :destroy, :initiator_scope, :accept]

  # GET /pitch_cards/1/comments
  # GET /pitch_cards/1/comments.json
  def index
    # Retrieve the comments (suggestions included) that the current user is permitted to see
    # @discourses = @pitch_card.comments.initiator_content_scoped_for(current_user).desc(:_id).page params[:page]
    @discourses = get_discourses(@pitch_card, current_user, params[:page])

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
    @comment.author_name = current_user.first_name + " " + current_user.last_name
    # Set the PitchCard initiator's id
    @comment.initiator_id = @pitch_card.initiator.id
    @comment.message_type = :root

    respond_to do |format|
      @comment = @comment.secret_save
      if @comment.errors.any?
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
    @comment = @comment.assign_attributes(comment_params)

    respond_to do |format|
      @comment = @comment.secret_save
      if @comment.errors.any?
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
    @comment.secret_destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /pitch_cards/1/comments/initiator_scope
  # POST /pitch_cards/1/comments/initiator_scope.json
  def initiator_scope
    # Inject the initiator scope object
    @scopes = ApplicationController.helpers.scopes(current_user)
    @comment.ic_scope = params[:ic_scope]
    @comment.inject_scopes(@scopes)

    respond_to do |format|
      @comment = @comment.secret_save
      if @comment.errors.any?
        msg = { :status => :ok, :message => "Success!", :content => params[:ic_scope] }
        format.json { render json: msg }
      else
        flash.now[:alert] = pluralize(@comment.errors.count, "error") + ' found, please fix before submitting'
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /pitch_cards/1/comments/1/accept
  # POST /pitch_cards/1/comments/1/accept.json
  def accept
    authorize! :manage, @pitch_card

    if params[:button] == "accept"
      # the user pressed accept

      @comment.status = :accepted

      @comment = @comment.secret_save
      if @comment.errors.any?
        # the comment update was successful
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Comment was successfully accepted.' }
          format.json { head :no_content }
        end
      else
        # the card update was successful but the comment was not
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Comment was accepted, but an error occurred...' }
          format.json { head :no_content }
        end
      end

    else # user pressed reject

      @comment.status = :rejected

      @comment = @comment.secret_save
      if @comment.errors.any?
        # the comment update was successful
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Comment was successfully rejected.' }
          format.json { head :no_content }
        end
      else
        # the comment update failed
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Failed to reject comment, please try again' }
          format.json { head :no_content }
        end
      end

    end

  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.secret_find(params[:id])
  end

  def set_pitch_card
    @pitch_card = PitchCard.secret_find(params[:pitch_card_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    # Screen the baddies
    params.require(:comment).permit(:pitch_point_id, :pitch_point_name, :comment, :initiator_content_scope, :i_scope, :c_scope, :ic_scope, :type, :first_name, :last_name)
  end

end
