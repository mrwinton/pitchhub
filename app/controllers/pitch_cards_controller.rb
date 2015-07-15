class PitchCardsController < ApplicationController
  include ActionView::Helpers::TextHelper
  layout 'backend/base'

  before_action :authenticate_user!
  before_action :set_pitch_card, only: [:show, :edit, :update, :destroy, :complete, :activate]

  # GET /pitch_cards
  # GET /pitch_cards.json
  def index
    # TODO will most likely implement "more" button functionality rather than pagination
    @pitch_cards = PitchCard.all
  end

  # GET /pitch_cards/1
  # GET /pitch_cards/1.json
  def show
    authorize! :read_pitch, @pitch_card
    @suggestion = Suggestion.new
    @comment = Comment.new
  end

  # GET /pitch_cards/new
  def new
    @pitch_card   = PitchCard.new

    # [ [ pitch point name, pitch point tool tip, pitch point place holder], ... ]
    @pitch_points = ApplicationController.helpers.pitch_points_hash
    # build the pitch card's points
    @pitch_points.length.times{@pitch_card.pitch_points.build}

  end

  # GET /pitch_cards/1/edit
  def edit
    authorize! :manage, @pitch_card
  end

  # POST /pitch_cards
  # POST /pitch_cards.json
  def create
    @pitch_card = PitchCard.new(pitch_card_params)

    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @pitch_card.inject_scopes(@scopes)
    # Set the current user as the PitchCard's initiator
    @pitch_card.initiator = current_user

    respond_to do |format|
      if @pitch_card.save
        format.html { redirect_to @pitch_card, notice: 'Pitch Card was successfully created.' }
        format.json { render :show, status: :created, location: @pitch_card }
      else
        @pitch_card.image.clear
        # PaperClip spits out redundant errors, so we compensate by subtracting by the redundant count
        num_errors = @pitch_card.errors.count - @pitch_card.errors[:pitch_card_image].count
        flash.now[:alert] = pluralize(num_errors, "error") + ' found, please fix before submitting'
        format.html { render :new }
        format.json { render json: @pitch_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pitch_cards/1
  # PATCH/PUT /pitch_cards/1.json
  def update
    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @pitch_card.i_scope = params[:pitch_card][:i_scope]
    @pitch_card.c_scope = params[:pitch_card][:c_scope]
    @pitch_card.remove_image = params[:pitch_card][:remove_image]
    @pitch_card.inject_scopes(@scopes)
    previous_image = @pitch_card.image

    respond_to do |format|
      if @pitch_card.update(pitch_card_params)
        format.html { redirect_to @pitch_card, notice: 'Pitch card was successfully updated.' }
        format.json { render :show, status: :ok, location: @pitch_card }
      else
        @pitch_card.image = previous_image
        # PaperClip spits out redundant errors, so we compensate by subtracting by the redundant count
        num_errors = @pitch_card.errors.count - @pitch_card.errors[:pitch_card_image].count
        flash.now[:alert] = pluralize(num_errors, "error") + ' found, please fix before submitting'
        format.html { render :edit }
        format.json { render json: @pitch_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitch_cards/1
  # DELETE /pitch_cards/1.json
  def destroy
    authorize! :manage, @pitch_card
    @pitch_card.destroy
    respond_to do |format|
      format.html { redirect_to initiated_pitch_cards_url, notice: 'Pitch card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /pitch_cards/1/complete
  # POST /pitch_cards/1/complete.json
  def complete
    authorize! :manage, @pitch_card
    @pitch_card.status = :complete
    respond_to do |format|
      if @pitch_card.save
        format.html { redirect_to @pitch_card, notice: 'Pitch card was successfully updated.' }
        format.json { render :show, status: :ok, location: @pitch_card }
      else
        format.html { redirect_to @pitch_card, notice: 'Pitch card failed to update, please try again.' }
        format.json { render :show, status: :ok, location: @pitch_card }
      end
    end
  end

  # POST /pitch_cards/1/activate
  # POST /pitch_cards/1/activate.json
  def activate
    authorize! :manage, @pitch_card
    @pitch_card.status = :active
    respond_to do |format|
      if @pitch_card.save
        format.html { redirect_to @pitch_card, notice: 'Pitch card was successfully updated.' }
        format.json { render :show, status: :ok, location: @pitch_card }
      else
        format.html { redirect_to @pitch_card, notice: 'Pitch card failed to update, please try again.' }
        format.json { render :show, status: :ok, location: @pitch_card }
      end
    end
  end

  # GET /initiated
  # GET /initiated.json
  def initiated
    @pitch_cards = current_user.init_pitch_cards.page params[:page]
    render 'index'
  end

  # GET /collabs
  # GET /collabs.json
  def collabs
    @pitch_cards = current_user.collab_pitch_cards.page params[:page]
    render 'index'
  end

  def search
      @pitch_cards = PitchCard.where(:'pitch_points.value' => /#{params["top-search"]}/).desc(:_id).page params[:page]
      render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pitch_card
      @pitch_card = PitchCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pitch_card_params
      # Screen the baddies
      params.require(:pitch_card).permit(:status, :i_scope, :c_scope, :image, :remove_image, pitch_points_attributes: [:id, :name, :selected, :value])
    end

end
