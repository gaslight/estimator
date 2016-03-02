defmodule Estimator.EstimationServerTest do

  use ExUnit.Case

  import Estimator.Factory

  alias Estimator.Estimation
  alias Estimator.EstimationServer

  setup do
    project = build(:project_with_team)
    story = build(:story, project: project)
    estimation = %Estimation{story: story}
    EstimationServer.start_link(name: :estimation_server)
    {:ok, estimation: estimation}
  end

  test "1 of 2 team members joining an estimation", %{ estimation: %Estimation{ story: story}} do
    EstimationServer.join_estimation(story, List.first(story.project.team_members))
    assert EstimationServer.get_estimation(story).state == :waiting_for_players
  end

end
