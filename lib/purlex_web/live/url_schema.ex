defmodule PurlexWeb.UrlSchema do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "url" do
    field :url, :string
  end

  @url_regex Purlex.Url.regex()

  @doc false
  def changeset(url_set, attrs) do
    url_set
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> validate_format(:url, @url_regex, message: "needs a valid URL")
  end

  @doc false
  def new_changeset do
    changeset(%PurlexWeb.UrlSchema{}, %{})
  end
end
