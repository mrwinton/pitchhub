require 'rails_helper'

RSpec.describe "PitchCards", type: :request do
  describe "GET /pitch_cards" do
    it "works! (now write some real specs)" do
      get pitch_cards_path
      expect(response).to have_http_status(200)
    end
  end
end
