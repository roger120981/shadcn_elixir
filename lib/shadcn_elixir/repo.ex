defmodule ShadcnElixir.Repo do
  use Ecto.Repo,
    otp_app: :shadcn_elixir,
    adapter: Ecto.Adapters.Postgres
end
