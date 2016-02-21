defmodule Mandioca.APIView do
  use Mandioca.Web, :view

  def render("index.json", %{apis: apis}) do
    %{data: render_many(apis, Mandioca.APIView, "api.json")}
  end

  def render("show.json", %{api: api}) do
    %{data: render_one(api, Mandioca.APIView, "api.json")}
  end

  def render("api.json", %{api: api}) do
    %{id: api.id,
      name: api.name,
      endpoint_url: api.endpoint_url,
      slug: api.slug}
  end
end
