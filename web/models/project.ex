defmodule Estimator.Project do
  use Estimator.Web, :model

  alias Estimator.TeamMember
  
  schema "projects" do
    field :name, :string

    timestamps
    has_many :team_members, TeamMember
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
