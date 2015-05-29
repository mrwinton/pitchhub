class DashboardController < ApplicationController
  layout 'backend/base'
  before_action :authenticate_user!

  def index
  end

end
