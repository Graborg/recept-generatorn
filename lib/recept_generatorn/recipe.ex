defmodule ReceptGeneratorn.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Phoenix.LiveView

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

  def create_recipe("", _), do: []
  def create_recipe(name, [] = ingredients) do
    %ReceptGeneratorn.Recipe{name: name, ingredients: ingredients}
      |> ReceptGeneratorn.Repo.insert()
  end

  def add_ingredient(_, ""), do: []
  def add_ingredient(recipe, ingredient) do
    old_recipe = ReceptGeneratorn.Recipe |> ReceptGeneratorn.Repo.get_by!(name: recipe) |> IO.inspect()
    changeset(old_recipe, %{ ingredients: [ingredient | old_recipe.ingredients ] })
      |> IO.inspect()
      |> ReceptGeneratorn.Repo.update()
  end

  def remove_recipe(recipe) do
    ReceptGeneratorn.Recipe
      |> ReceptGeneratorn.Repo.get_by!(name: recipe)
      |> ReceptGeneratorn.Repo.delete()
  end

  def remove_ingredient(recipe, ingredient) do
    ReceptGeneratorn.Recipe
      |> ReceptGeneratorn.Repo.get_by!(name: recipe)
      |> (fn old_recipe -> changeset(old_recipe, %{ ingredients: old_recipe.ingredients -- [ingredient] }) end).()
      |> ReceptGeneratorn.Repo.update()
  end


  def get_random_recipe() do
    query =
      from ReceptGeneratorn.Recipe,
        order_by: fragment("RANDOM()"),
        limit: 1

    List.first(ReceptGeneratorn.Repo.all(query))
  end
end
