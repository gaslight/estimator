defmodule EstimationTest do
  use ExUnit.Case
  import Estimator.Factory

  alias Estimator.Estimation

  setup do
    project = build(:project_with_team)
    story = build(:story, project: project)
    estimation = %Estimation{story: story}
    {:ok, project: project, story: story, estimation: estimation}
  end

  test "joining an estimation", %{story: story, project: project, estimation: estimation} do
    team_member1 = hd(project.team_members)
    estimation = Estimation.join_estimation(estimation, team_member1)
    assert estimation.joined_team_members == MapSet.new([team_member1])
    assert estimation.state == :waiting_for_players
  end

  test "all players joined", %{story: story, project: project, estimation: estimation} do
    [team_member1, team_member2] = project.team_members
    estimation = Estimation.join_estimation(estimation, team_member1)
    estimation = Estimation.join_estimation(estimation, team_member2)
    assert estimation.joined_team_members == MapSet.new([team_member1, team_member2])
    assert estimation.state == :estimating
  end

  test "adding one estimate" do
  end

end
