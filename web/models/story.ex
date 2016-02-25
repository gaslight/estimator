defmodule Estimator.Story do
  use Estimator.Web, :model
  alias Estimator.Project
  
  schema "stories" do
    field :title, :string
    field :description, :string
    field :estimate, :integer
    belongs_to :project, Project

    timestamps
  end

  @required_fields ~w(title description)
  @optional_fields ~w(project_id estimate)

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
