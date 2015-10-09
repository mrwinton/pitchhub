require 'test_helper'
require 'rails/performance_test_help'

class PitchCardsDashboardTest < ActionDispatch::PerformanceTest
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

  test "PitchCardDashboardPage" do
    get '/'
  end
end
