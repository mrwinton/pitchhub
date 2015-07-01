class SuggestionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  layout :nil

  # GET /pitch_cards/1/suggestions
  # GET /pitch_cards/1/suggestions.json
  def index

    permitted_comments = @pitch_card.comments.select{|comment| can? :read_content, comment}
    @discourses = permitted_comments.page params[:page]
    # TODO for each discourse get it's children comments (if any)

    respond_to do |format|
      format.js
    end

  end

  # GET /pitch_cards/1/suggestions/new
  def new

    @pitch_card = PitchCard.find(params[:pitch_card_id])
    @suggestion = Suggestion.new
    @suggestion.content = params[:content]
    @pitch_point_id = params[:pitch_point_id]
    @pitch_point_name = params[:pitch_point_name]

    respond_to do |format|
      format.js
    end

  end

  # GET /pitch_cards/1/suggestions/1/edit
  def edit
    authorize! :manage, @suggestion
  end

  # POST /pitch_cards/1/suggestions
  # POST /pitch_cards/1/suggestions.json
  def create

    @pitch_card = PitchCard.find(params[:pitch_card_id])

    @suggestion = @pitch_card.comments.build(suggestion_params, Suggestion)

    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @suggestion.inject_scopes(@scopes)
    # Set the current user as the Suggestion's initiator
    @suggestion.author = current_user
    @suggestion.message_type = :root
    @suggestion.author_name = current_user.first_name + " " + current_user.last_name

    respond_to do |format|
      if @suggestion.save
        flash.now[:notice] = 'Suggestion was successfully created.'
        format.html { redirect_to :back, notice: 'Suggestion was successfully created.' }
      else
        flash.now[:alert] = pluralize(@suggestion.errors.count, "error") + ' found, please try again'
        format.html { redirect_to :back }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pitch_cards/1/suggestions/1
  # PATCH/PUT /pitch_cards/1/suggestions/1.json
  def update
    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @suggestion.i_scope = params[:suggestion][:i_scope]
    @suggestion.c_scope = params[:suggestion][:c_scope]
    @suggestion.inject_scopes(@scopes)

    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        flash.now[:alert] = pluralize(@suggestion.errors.count, "error") + ' found, please fix before submitting'
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitch_cards/1/suggestions/1
  # DELETE /pitch_cards/1/suggestions/1.json
  def destroy
    authorize! :manage, @suggestion
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_params
      # Screen the baddies
      params.require(:suggestion).permit(:pitch_point_id, :pitch_point_name, :content, :comment, :i_scope, :c_scope, :ic_scope, :type, :first_name, :last_name)
    end

end
