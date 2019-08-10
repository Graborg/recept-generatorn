defmodule ReceptGeneratorn.Repo do
  use Ecto.Repo,
    otp_app: :recept_generatorn,
    adapter: Ecto.Adapters.Postgres
end
