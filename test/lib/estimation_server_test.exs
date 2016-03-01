defmodule Estimator.EstimationServerTest do

  use Estimator.ConnCase

  alias Estimator.EstimationServer
  alias Estimator.Story
  alias Estimator.Estimation
  alias Estimator.TeamMember

  test "1 of 2 team members joining an estimation" do
    story = %Story{id: 1, title: "Hey"}
    team_member = %TeamMember{email: "foo@bar.com"}
    EstimationServer.join_estimation(story, team_member)
    assert EstimationServer.get_estimation(story).state == :waiting_for_players
  end
  
end
