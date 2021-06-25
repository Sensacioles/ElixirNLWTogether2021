defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true
  alias Wabanex.{User,Users.Create}

  describe "users queries" do
    test "returns user on valid id", %{conn: conn} do
      params = %{email: "gio@gio.com", name: "Gio", password: "123321"}
      {:ok, %User{id: user_id}} = Create.call(params)
      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """
      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)
      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "gio@gio.com",
            "name" => "Gio"
          }
        }
      }
      assert response == expected_response
    end
    test "returns error on invalid id", %{conn: conn} do
      invalid_id = "thisisaninvalidid"
      query = """
        {
          getUser(id: "#{invalid_id}"){
            name
            email
          }
        }
      """
      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)
      expected_response = %{"errors" => [%{"locations" => [%{"column" => 13, "line" => 2}], "message" => "Argument \"id\" has invalid value \"#{invalid_id}\"."}]}
      assert response == expected_response
    end
  end
  describe "users mutations" do
    test "when params are valid, create user", %{conn: conn} do
      mutation = """
        mutation{
          createUser(input: {
            name: "Sasageyo",
            email: "sasageyo@shinzouwo.com",
            password: "sasageyo"}){
              id
              name
          }
        }
      """
      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)
      assert %{
        "data" => %{
          "createUser" => %{
            "id" => _id,
            "name" => "Sasageyo"
          }
        }
      } = response
    end
  end
end
