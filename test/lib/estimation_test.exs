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

  test "adding one estimate", %{story: story, project: project, estimation: estimation} do
    [team_member1, team_member2] = project.team_members
    estimation = estimation
    |> Estimation.join_estimation(team_member1)
    |> Estimation.join_estimation(team_member2)
    |> Estimation.estimate(team_member1, 3)
    assert estimation.state == :estimating
    assert Enum.count(estimation.estimates) == 1
  end

  test "adding two estimate", %{story: story, project: project, estimation: estimation} do
    [team_member1, team_member2] = project.team_members
    estimation = estimation
    |> Estimation.join_estimation(team_member1)
    |> Estimation.join_estimation(team_member2)
    |> Estimation.estimate(team_member1, 3)
    |> Estimation.estimate(team_member2, 2)
    assert estimation.state == :disagree
    assert Enum.count(estimation.estimates) == 2
  end

end
