defmodule ReceptGeneratorn.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :ingredients, {:array, :string}
      add :last_used, :date

      timestamps()
    end

  end
end
