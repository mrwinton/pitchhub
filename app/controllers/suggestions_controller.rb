class SuggestionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  include SecretSharingController
  before_action :authenticate_user!
  before_action :set_pitch_card, only: [:index, :new, :create, :update, :destroy, :accept]
  before_action :set_suggestion, only: [:update, :destroy, :initiator_scope, :accept]

  # GET /pitch_cards/1/suggestions
  # GET /pitch_cards/1/suggestions.json
  def index
    # Retrieve the comments (suggestions included) that the current user is permitted to see
    @discourses = get_discourses(@pitch_card, current_user, params[:page])

    # TODO for each discourse get it's children comments (if any)

    respond_to do |format|
      format.js
    end
  end

  # GET /pitch_cards/1/suggestions/new
  def new
    @suggestion = Suggestion.new
    @suggestion.content = params[:content]
    @pitch_point_id = params[:pitch_point_id]
    @pitch_point_name = params[:pitch_point_name]

    respond_to do |format|
      format.js
    end
  end

  # POST /pitch_cards/1/suggestions
  # POST /pitch_cards/1/suggestions.json
  def create
    # Create the suggestion in the pitch card's comments relation
    @suggestion = @pitch_card.comments.build(suggestion_params, Suggestion)
    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @suggestion.inject_scopes(@scopes)
    # Set the current user as the Suggestion's initiator
    @suggestion.author = current_user
    @suggestion.author_name = current_user.first_name + " " + current_user.last_name
    # Set the PitchCard initiator's id
    @suggestion.initiator_id = @pitch_card.initiator.id
    @suggestion.message_type = :root

    respond_to do |format|
      @suggestion = @suggestion.secret_save
      if @suggestion.valid?
        current_user.collab_pitch_cards << @pitch_card
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
      @suggestion = @suggestion.secret_save
      if @suggestion.valid?
        format.html { redirect_to :back, notice: 'Suggestion was successfully updated.' }
      else
        flash.now[:alert] = pluralize(@suggestion.errors.count, "error") + ' found, please fix before submitting'
        format.html { redirect_to :back }
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
      format.html { redirect_to :back, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /pitch_cards/1/suggestions/initiator_scope
  # POST /pitch_cards/1/suggestions/initiator_scope.json
  def initiator_scope
    # Inject the initiator scope object
    @scopes = ApplicationController.helpers.scopes(current_user)
    @suggestion.ic_scope = params[:ic_scope]
    @suggestion.inject_scopes(@scopes)

    respond_to do |format|
      @suggestion = @suggestion.secret_save
      if @suggestion.valid?
        msg = { :status => :ok, :message => "Success!", :content => params[:ic_scope] }
        format.json { render json: msg }
      else
        flash.now[:alert] = pluralize(@suggestion.errors.count, "error") + ' found, please fix before submitting'
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /pitch_cards/1/suggestions/1/accept
  # POST /pitch_cards/1/suggestions/1/accept.json
  def accept
    authorize! :manage, @pitch_card

    if params[:button] == "accept"
      # the user pressed accept

      updated_content = @suggestion.content
      pitch_point_id = @suggestion.pitch_point_id
      @suggestion.status = :accepted

      @pitch_card.pitch_points_attributes = [
          { id: pitch_point_id, value: updated_content }
      ]

      @pitch_card = @pitch_card.secret_save
      if @pitch_card.valid?
        @suggestion = @suggestion.secret_save
        if @suggestion.valid?
          # the card and suggestion updates were successful
          respond_to do |format|
            format.html { redirect_to :back, notice: 'Suggestion was successfully accepted.' }
            format.json { head :no_content }
          end
        else
          # the card update was successful but the suggestion was not
          respond_to do |format|
            format.html { redirect_to :back, notice: 'Suggestion was accepted, but an error occurred...' }
            format.json { head :no_content }
          end
        end
      else
        # the card update was not successful
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Failed to accept suggestion, please try again' }
          format.json { head :no_content }
        end
      end

    else # user pressed reject

      @suggestion.status = :rejected

      @suggestion = @suggestion.secret_save
      if @suggestion.valid?
        # the suggestion update was successful
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Suggestion was successfully rejected.' }
          format.json { head :no_content }
        end
      else
        # the suggestion update failed
        respond_to do |format|
          format.html { redirect_to :back, notice: 'Failed to reject suggestion, please try again' }
          format.json { head :no_content }
        end
      end

    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_suggestion
    @suggestion = Suggestion.secret_find(params[:id])
  end

  def set_pitch_card
    @pitch_card = PitchCard.secret_find(params[:pitch_card_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def suggestion_params
    # Screen the baddies
    params.require(:suggestion).permit(:pitch_point_id, :pitch_point_name, :content, :comment, :i_scope, :c_scope, :ic_scope, :type, :first_name, :last_name)
  end

end
