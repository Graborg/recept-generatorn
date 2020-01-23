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
    |> validate_required([:name, :ingredients])
  end

  def get_all_recipes() do
    ReceptGeneratorn.Recipe
    |> ReceptGeneratorn.Repo.all()
  end

  def create_recipe(name, [] = ingredients) do
    %ReceptGeneratorn.Recipe{name: name, ingredients: ingredients}
      |> ReceptGeneratorn.Repo.insert()
  end

  def add_ingredient(recipe, ingredient) do
    old_recipe = ReceptGeneratorn.Recipe |> ReceptGeneratorn.Repo.get_by!(name: recipe) |> IO.inspect()
    changeset(old_recipe, %{ ingredients: [ingredient | old_recipe.ingredients ] })
      |> IO.inspect()
      |> ReceptGeneratorn.Repo.update()
  end
end
