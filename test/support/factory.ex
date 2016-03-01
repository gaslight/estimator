defmodule Estimator.Factory do

  use ExMachina.Ecto, repo: Estimator.Repo

  alias Estimator.Story
  alias Estimator.Project
  alias Estimator.TeamMember
  
  def factory(:story) do
    %Story{
      title: "Make something",
      description: "Its ok",
      project: build(:project)
    }
  end

  def factory(:project) do
    %Project{
      name: "A good project"
    }
  end

  def factory(:project_with_team) do
    %Project{
      name: "A good project",
      team_members: [build(:team_member), build(:team_member)]
    }
  end

  def factory(:team_member) do
    %TeamMember{
      email: sequence(:email, &"email_#{&1}@example.com"),
      project: build(:project)
    }
  end
end
