require 'rails_helper'

RSpec.describe "pitch_cards/edit", type: :view do
  before(:each) do
    @pitch_card = assign(:pitch_card, PitchCard.create!())
  end

  it "renders the edit pitch_card form" do
    render

    assert_select "form[action=?][method=?]", pitch_card_path(@pitch_card), "post" do
    end
  end
end
