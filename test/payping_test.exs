defmodule PayPingTest do
  use ExUnit.Case

  describe "config" do
    test "it should return :payping config" do
      config = PayPing.config()
      assert [:token, :base_url] |> Enum.all?(&Map.has_key?(config, &1))
    end
  end

  describe "payment" do
    test "it should throw 400 error when return url is invalid" do
      pay_res = PayPing.pay(%{amount: 100, returnUrl: "/wrong"})

      assert {:error, 400, %{"ReturnUrl" => _}} = pay_res
    end

    test "it should create a payment code" do
      pay_res =
        PayPing.pay(%{amount: 100, returnUrl: "https://example.com/api/payments/cb/payping"})

      assert {:ok, 200, %{"code" => _}} = pay_res
    end

    test "it should throw 400 error when refid is invalid to be verified" do
      verify_res = PayPing.verify(%{amount: 100, refId: "test"})

      assert {:error, 400, %{"44" => _}} = verify_res
    end
  end
end
