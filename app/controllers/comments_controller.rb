class CommentsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!
  before_action :set_pitch_card, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  layout :nil

  # GET /pitch_cards/1/comments
  # GET /pitch_cards/1/comments.json
  def index

    permitted_comments = @pitch_card.comments.select{|comment| can? :read_content, comment}
    @discourses = Kaminari.paginate_array(permitted_comments).page(params[:page]).per(10)

    # TODO for each discourse get it's children comments (if any)

    respond_to do |format|
      format.js
    end

  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    authorize! :read, @comment
  end

  # GET /comments/new
  def new

    @comment = Comment.new

    respond_to do |format|
      # format.html { redirect_to root_path } #for my controller, i wanted it to be JS only
      format.js
    end

  end

  # GET /comments/1/edit
  def edit
    authorize! :manage, @comment
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @comment.inject_scopes(@scopes)
    # Set the current user as the Comment's initiator
    @comment.author = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        flash.now[:alert] = pluralize(@comment.errors.count, "error") + ' found, please fix before submitting'
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @comment.i_scope = params[:comment][:i_scope]
    @comment.c_scope = params[:comment][:c_scope]
    @comment.inject_scopes(@scopes)

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        flash.now[:alert] = pluralize(@comment.errors.count, "error") + ' found, please fix before submitting'
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    authorize! :manage, @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pitch_card
      @pitch_card = PitchCard.find(params[:pitch_card_id])
    end


    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      # Screen the baddies
      params.require(:comment).permit(:content, :comment, :i_scope, :c_scope, :type, :first_name, :last_name)
    end

end
