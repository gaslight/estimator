defmodule Estimator.EstimationServer do

  use GenServer
  alias Estimator.Estimation

  # Client API

  def start_link(opts \\ []) do
    {:ok, pid} = GenServer.start_link(__MODULE__, %{}, opts)
  end

  def join_estimation(story, team_member) do
    GenServer.call(:estimation_server, {:join_estimation, story, team_member})
  end

  def get_estimation(story) do
    %Estimation{}
  end

  def handle_call({:join_estimation, story, team_member}, _from, estimations) do
    estimation = estimations |> Map.put_new(story.id, %Estimation{}) |> Map.get(story.id)
    # {:reply, {:ok, Map.put(estim)
  end
end
