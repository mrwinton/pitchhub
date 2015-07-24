class DashboardController < ApplicationController
  layout 'backend/base'
  before_action :authenticate_user!

  def index

    # Retrieve the Pitch Cards that the current user is permitted to see, sort most recent first
    @pitch_cards = PitchCard.content_scoped_for(current_user).desc(:_id).page params[:page]

    render 'index'
  end

end
