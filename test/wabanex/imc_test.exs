defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true
  alias Wabanex.IMC

  describe "calculate/1" do
    test "when file exists, return data" do
      params = %{"filename" => "students.csv"}
      response = IMC.calculate(params)
      expected_response =
        {:ok,
          %{
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
    test "when file doesnt exist, return error" do
      params = %{"filename" => "aa.csv"}
      response = IMC.calculate(params)
      expected_response = {:error, "Error while opening the file"}
      assert response == expected_response
    end
  end
end
