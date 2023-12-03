defmodule KdsTreningy.Repo do
  use Ecto.Repo,
    otp_app: :kds_treningy,
    adapter: Ecto.Adapters.Postgres
end
