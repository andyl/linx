defmodule Linx.Repo do
  use Ecto.Repo,
    otp_app: :linx,
    adapter: Ecto.Adapters.Postgres
end
