defmodule Estimator.Repo.Migrations.CreateStory do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :description, :string
      add :estimate, :integer

      timestamps
    end

  end
end
