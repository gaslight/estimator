defmodule Estimator.Repo.Migrations.StoryBelongsToProject do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :project_id, references(:projects)
    end
  end
end
