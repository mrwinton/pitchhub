class PitchCardsController < ApplicationController
  layout 'backend/base'

  before_action :set_pitch_card, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /pitch_cards
  # GET /pitch_cards.json
  def index
    @pitch_cards = PitchCard.all
  end

  # GET /pitch_cards/1
  # GET /pitch_cards/1.json
  def show
  end

  # GET /pitch_cards/new
  def new
    # [ [ pitch point name, pitch point tool tip, pitch point place holder], ... ]
    @pitch_points = PitchPoint.points
    @pitch_card   = PitchCard.new
  end

  # GET /pitch_cards/1/edit
  def edit
  end

  # POST /pitch_cards
  # POST /pitch_cards.json
  def create
    @pitch_card = PitchCard.new(pitch_card_params)

    respond_to do |format|
      if @pitch_card.save
        format.html { redirect_to @pitch_card, notice: 'Pitch card was successfully created.' }
        format.json { render :show, status: :created, location: @pitch_card }
      else
        format.html { render :new }
        format.json { render json: @pitch_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pitch_cards/1
  # PATCH/PUT /pitch_cards/1.json
  def update
    respond_to do |format|
      if @pitch_card.update(pitch_card_params)
        format.html { redirect_to @pitch_card, notice: 'Pitch card was successfully updated.' }
        format.json { render :show, status: :ok, location: @pitch_card }
      else
        format.html { render :edit }
        format.json { render json: @pitch_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitch_cards/1
  # DELETE /pitch_cards/1.json
  def destroy
    @pitch_card.destroy
    respond_to do |format|
      format.html { redirect_to pitch_cards_url, notice: 'Pitch card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pitch_card
      @pitch_card = PitchCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pitch_card_params
      params[:pitch_card]
    end
end
