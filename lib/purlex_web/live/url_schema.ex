defmodule PurlexWeb.UrlSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "url" do
    field :url, :string
    field :alt, :string
  end

  @url ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/
  @alias ~r/^[A-Za-z0-9\.\-\_]+$/

  @doc false
  def changeset(url_set, attrs) do
    url_set
    |> cast(attrs, [:url, :alt])
    |> validate_required([:url])
    |> validate_length(:alt, max: 12)
    |> validate_format(:alt, @alt, message: "only alpha-numeric, period, dash, underscore")
    |> validate_format(:url, @url, message: "must be a valid URL")
  end

  # TODO: add duplication function for alt (with days)
  # NOTE: url can be duplicated!
end
