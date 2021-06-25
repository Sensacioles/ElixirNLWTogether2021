defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true
  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns valid changeset" do
      params = %{name: "Bisi", email: "bisi@bisi.com", password: "bisi123"}
      response = User.changeset(params)
      assert %Ecto.Changeset{
        valid?: true,
        changes: %{
          name: "Bisi",
          email: "bisi@bisi.com",
          password: "bisi123"},
          errors: []
      } = response
    end
    test "when params are invalid, returns invalid changeset" do
      params = %{name: "a", email: "bisi@bisi.com"}
      response = User.changeset(params)
      expected_response = %{
        name: ["should be at least 3 character(s)"],
        password: ["can't be blank"]
      }
      assert errors_on(response) == expected_response
    end
  end
end
