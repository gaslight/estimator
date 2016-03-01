defmodule Estimator.Estimation do
  defstruct state: :waiting_for_players, joined_team_members: MapSet.new, story: nil

  alias Estimator.Estimation

  def join_estimation(estimation, team_member) do
    %{ estimation |joined_team_members: MapSet.put(estimation.joined_team_members, team_member) }
    |> calculate_state
  end

  defp calculate_state(estimation) do
    if estimation.joined_team_members == MapSet.new(estimation.story.project.team_members) do
      %{ estimation | state: :estimating }
    else
      estimation
    end
  end

end
