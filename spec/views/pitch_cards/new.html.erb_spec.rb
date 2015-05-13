require 'rails_helper'

RSpec.describe "pitch_cards/new", type: :view do
  before(:each) do
    assign(:pitch_card, PitchCard.new())
  end

  it "renders new pitch_card form" do
    render

    assert_select "form[action=?][method=?]", pitch_cards_path, "post" do
    end
  end
end
