defmodule PayPing.HTTP do
  @moduledoc false
  use HTTPoison.Base

  def process_url(url) do
    base_url = Application.get_env(:payping, :base_url) || "https://api.payping.ir"
    base_url <> url
  end

  def process_request_headers(headers) do
    token = Application.get_env(:payping, :token)

    custom_headers = [
      {"Content-Type", "application/json"},
      {"Authorization", token}
    ]

    headers ++ custom_headers
  end

  def process_response_body(body) do
    case Jason.decode(body) do
      {:ok, decoded} ->
        decoded

      {:error, %Jason.DecodeError{}} ->
        body
    end
  end

  @doc """
  Execute
  """
  @spec async_handler(any) :: term | {:error, integer | nil, term}
  def async_handler(fun) do
    req =
      Task.async(fn ->
        case fun.() do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            {:ok, 200, body}

          {:ok,
           %HTTPoison.Response{
             status_code: status_code,
             body: body
           }} ->
            {:error, status_code, body}

          {:error, %HTTPoison.Error{reason: reason}} ->
            {:error, nil, reason}
        end
      end)

    Task.await(req)
  end
end
