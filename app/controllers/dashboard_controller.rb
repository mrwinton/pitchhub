class DashboardController < ApplicationController
  layout 'backend/base'
  before_action :authenticate_user!

  def index

    # Retrieve the Pitch Cards that the current user is permitted to see
    permitted_cards = PitchCard.all.select{|pitch_card| can? :read_pitch, pitch_card}

    # Sort most recent first
    @pitch_cards = permitted_cards.sort_by {|obj| -obj.created_at.to_f}

    render 'index'
  end

end
