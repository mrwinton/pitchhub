require 'rails_helper'

RSpec.describe "pitch_cards/show", type: :view do
  before(:each) do
    @pitch_card = assign(:pitch_card, PitchCard.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
