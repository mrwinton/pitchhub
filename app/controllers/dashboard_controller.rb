class DashboardController < ApplicationController
  layout 'backend/base'
  before_action :authenticate_user!

  def index

    # Retrieve the Pitch Cards that the current user is permitted to see, sort most recent first
    @pitch_cards = PitchCard.content_scoped_for(current_user).order_by(:created_at => 'desc').page params[:page]
    render 'pitch_cards/index', :locals => {:title => 'Pitch Cards Dashboard'}
  end

end
