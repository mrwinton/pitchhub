require 'rails_helper'

RSpec.describe "pitch_cards/index", type: :view do
  before(:each) do
    assign(:pitch_cards, [
      PitchCard.create!(),
      PitchCard.create!()
    ])
  end

  it "renders a list of pitch_cards" do
    render
  end
end
