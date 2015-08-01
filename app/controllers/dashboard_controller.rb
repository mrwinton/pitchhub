class DashboardController < ApplicationController
  include SecretSharingController
  layout 'backend/base'
  before_action :authenticate_user!

  def index

    # Retrieve the Pitch Cards that the current user is permitted to see, sort most recent first
    @pitch_cards = get_pitch_cards_encrypted(current_user, params[:page])

    render 'index'
  end

end
