require 'test_helper'
require 'rails/performance_test_help'

class PitchCardShowTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 10, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance/10', formats: [:flat] }

  # self.profile_options = { runs: 100, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance/100', formats: [:flat] }
  #
  self.profile_options = { runs: 10, metrics: [:wall_time, :memory],
                           output: 'tmp/performance/1000', formats: [:flat] }
  #
  # self.profile_options = { runs: 10000, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance/10000', formats: [:flat] }


  # called before every single test
  def setup
    help_setup
    login_for_performance_test
    db = SecretSharingHelper.databases.reject{ |db| db[:type] == "sql" }.first
    # PitchCard.with(database: db[:name]).content_scoped_for(user).desc(:_id).page( page )
    @pitch_card = PitchCard.with(session: db[:name]).skip(rand(2000)).first
  end

  # called after every single test
  def teardown
    help_tear_down
  end

  test "PitchCardShowPage" do
    # pitch_card = PitchCard.first

    pitch_card_path = pitch_card_path(@pitch_card)
    get pitch_card_path
  end
end
