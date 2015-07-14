require 'test_helper'
require 'rails/performance_test_help'

class PitchCardsInitiatedTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  # called before every single test
  def setup
    help_setup
    login_for_performance_test
  end

  # called after every single test
  def teardown
    help_tear_down
  end

  test "InitiatedPitchCardsPage" do

    get initiated_pitch_cards_path
  end
end
