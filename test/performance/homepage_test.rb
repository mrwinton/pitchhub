require 'test_helper'
require 'rails/performance_test_help'

class HomepageTest < ActionDispatch::PerformanceTest
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

  test "homepage" do
    get '/'
  end
end
