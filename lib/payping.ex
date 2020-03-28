defmodule PayPing do
  @moduledoc """
  PayPing Elixir
  """
  @moduledoc since: "0.1.0"

  alias API

  @type http_error :: {:error, integer, term}

  @doc """
  Get configuration
  """
  @doc since: "0.1.0"
  @spec config() :: %{base_url: String.t(), token: String.t()}
  def config() do
    token = Application.get_env(:payping, :token, "")
    base_url = Application.get_env(:payping, :base_url, "https://api.payping.ir")

    %{
      token: token,
      base_url: base_url
    }
  end

  @doc """
  Create a Payment code
  """
  @doc since: "0.1.0"
  @spec pay(%{
          required(:amount) => integer,
          optional(:payerIdentity) => String.t(),
          optional(:payerName) => String.t(),
          optional(:description) => String.t(),
          required(:returnUrl) => String.t(),
          optional(:clientRefId) => String.t()
        }) :: %{code: String.t()} | http_error
  def pay(
        %{
          amount: _,
          returnUrl: _
        } = params
      ) do
    HTTP.async_handler(fn -> HTTP.post("/v2/pay", Jason.encode!(params)) end)
  end

  @doc """
  Verify a Payment
  """
  @doc since: "0.1.0"
  @type verify_params :: %{
          required(:refId) => String.t(),
          required(:amount) => integer
        }
  @type verify_ok :: %{amount: integer, cardNumber: String.t(), cardHashPan: String.t()}
  @spec verify(params :: verify_params) :: verify_ok | http_error
  def verify(
        %{
          refId: _,
          amount: _
        } = params
      ) do
    HTTP.async_handler(fn -> HTTP.post("/v2/pay/verify", Jason.encode!(params)) end)
  end
end
