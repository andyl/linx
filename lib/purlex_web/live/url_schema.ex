defmodule PurlexWeb.UrlSchema do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "url" do
    field :url, :string
    field :alt, :string
  end

  @url_regex Purlex.Url.regex()
  @alt_regex ~r/^[A-Za-z0-9\.\-\_]+$/

  @doc false
  def changeset(url_set, attrs) do
    url_set
    |> cast(attrs, [:url, :alt])
    |> validate_required([:url])
    |> validate_length(:alt, max: 12)
    |> validate_format(:alt, @alt_regex, message: "only alpha-numeric, period, dash, underscore")
    |> validate_format(:url, @url_regex, message: "needs a valid URL")
  end

  @doc false
  def new_changeset do
    changeset(%PurlexWeb.UrlSchema{}, %{})
  end

  # TODO: add duplication function for alt (with days)
  # NOTE: url can be duplicated!
  # NOTE: check to ensure the url exists
end
