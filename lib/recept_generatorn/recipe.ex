defmodule ReceptGeneratorn.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :ingredients, {:array, :string}
    field :last_used, :date
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :ingredients, :last_used])
    |> validate_required([:name, :ingredients, :last_used])
  end
end
