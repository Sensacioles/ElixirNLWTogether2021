defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when params are valid, returns imc",%{conn: conn} do
      params = %{"filename" => "students.csv"}
      response =
      conn
      |> get(Routes.imc_path(conn, :index, params))
      |> json_response(:ok)
      expected_response =  %{
        "result" => %{
          "Dani" => 23.437499999999996,
          "Diego" => 23.04002019946976,
          "Gabul" => 22.857142857142858,
          "Gio" => 18.30576947355132,
          "Rafael" => 24.897060231734173,
          "Rodrigo" => 26.234567901234566,
          "Sasa" => 17.301038062283737
        }
      }
      assert response == expected_response
    end
    test "when params are invalid, returns error",%{conn: conn} do
      params = %{"filename" => "aa.csv"}
      response =
      conn
      |> get(Routes.imc_path(conn, :index, params))
      |> json_response(:bad_request)
      expected_response = %{"result" => "Error while opening the file"}
      assert response == expected_response
    end
  end
end
