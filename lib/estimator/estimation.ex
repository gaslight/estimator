defmodule Estimator.Estimation do
  defstruct state: :waiting_for_players,
            joined_team_members: MapSet.new,
            story: nil,
            estimates: []

  alias Estimator.Estimation

  def join_estimation(estimation, team_member) do
    %{ estimation |joined_team_members: MapSet.put(estimation.joined_team_members, team_member) }
    |> calculate_state
  end

  def estimate(estimation, team_member, estimate) do
    %{ estimation | estimates: [ estimate | estimation.estimates ] }
    |> calculate_state
  end

  defp calculate_state(estimation = %Estimation{state: :waiting_for_players}) do
    if estimation.joined_team_members == MapSet.new(estimation.story.project.team_members) do
      %{ estimation | state: :estimating }
    else
      estimation
    end
  end

  defp calculate_state(estimation = %Estimation{state: :estimating, estimates: estimates}) do
    if Enum.count(estimates) == Enum.count(estimation.story.project.team_members) do
      %{ estimation | state: :disagree }
    else
      estimation
    end
  end

end
