json.array!(@pitch_cards) do |pitch_card|
  json.extract! pitch_card, :id
  json.url pitch_card_url(pitch_card, format: :json)
end
