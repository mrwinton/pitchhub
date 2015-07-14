require 'test_helper'
require 'rails/performance_test_help'

class PitchCardCreateTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 10, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance/10', formats: [:flat] }

  # self.profile_options = { runs: 100, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance/100', formats: [:flat] }
  #
  self.profile_options = { runs: 1000, metrics: [:wall_time, :memory],
                           output: 'tmp/performance/1000', formats: [:flat] }
  #
  # self.profile_options = { runs: 10000, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance/10000', formats: [:flat] }

  # called before every single test
  def setup
    help_setup
    login_for_performance_test
  end

  # called after every single test
  def teardown
    help_tear_down
  end

  test "pitch_card_create" do

    post pitch_cards_path, "utf8"=>"✓", "authenticity_token"=>"[FILTERED]", "pitch_card"=>{"remove_image"=>"false", "pitch_points_attributes"=>{"0"=>{"name"=>"Value Proposition", "value"=>"test", "selected"=>"true"}, "1"=>{"name"=>"Business Opportunity", "value"=>"test", "selected"=>"true"}, "2"=>{"name"=>"Resources", "value"=>"tet", "selected"=>"true"}, "3"=>{"name"=>"Solution", "selected"=>"false"}, "4"=>{"name"=>"Facilitation", "value"=>"test", "selected"=>"true"}, "5"=>{"name"=>"Voting", "value"=>"test", "selected"=>"true"}}, "i_scope"=>"public", "c_scope"=>"public"}, "commit"=>"Pitch"

  end
end
