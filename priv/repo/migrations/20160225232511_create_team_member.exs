defmodule Estimator.Repo.Migrations.CreateTeamMember do
  use Ecto.Migration

  def change do
    create table(:team_members) do
      add :email, :string
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps
    end
    create index(:team_members, [:project_id])

  end
end
