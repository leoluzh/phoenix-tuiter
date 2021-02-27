defmodule Tuiter.Repo do
  use Ecto.Repo,
    otp_app: :tuiter,
    adapter: Ecto.Adapters.Postgres
end
