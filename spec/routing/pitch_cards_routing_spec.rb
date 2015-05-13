require "rails_helper"

RSpec.describe PitchCardsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pitch_cards").to route_to("pitch_cards#index")
    end

    it "routes to #new" do
      expect(:get => "/pitch_cards/new").to route_to("pitch_cards#new")
    end

    it "routes to #show" do
      expect(:get => "/pitch_cards/1").to route_to("pitch_cards#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pitch_cards/1/edit").to route_to("pitch_cards#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pitch_cards").to route_to("pitch_cards#create")
    end

    it "routes to #update" do
      expect(:put => "/pitch_cards/1").to route_to("pitch_cards#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pitch_cards/1").to route_to("pitch_cards#destroy", :id => "1")
    end

  end
end
