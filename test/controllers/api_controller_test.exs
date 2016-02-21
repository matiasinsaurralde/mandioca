defmodule Mandioca.APIControllerTest do
  use Mandioca.ConnCase

  alias Mandioca.API
  @valid_attrs %{endpoint_url: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    api = Repo.insert! %API{}
    conn = get conn, api_path(conn, :show, api)
    assert json_response(conn, 200)["data"] == %{"id" => api.id,
      "name" => api.name,
      "endpoint_url" => api.endpoint_url,
      "slug" => api.slug}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_path(conn, :create), api: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(API, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_path(conn, :create), api: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    api = Repo.insert! %API{}
    conn = put conn, api_path(conn, :update, api), api: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(API, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    api = Repo.insert! %API{}
    conn = put conn, api_path(conn, :update, api), api: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    api = Repo.insert! %API{}
    conn = delete conn, api_path(conn, :delete, api)
    assert response(conn, 204)
    refute Repo.get(API, api.id)
  end
end
