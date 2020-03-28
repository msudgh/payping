defmodule HTTP do
  @moduledoc """
  HTTP Client Wrapper
  """
  use HTTPoison.Base
  alias PayPing

  @token PayPing.config()[:token]
  @base_url PayPing.config()[:base_url]

  def process_url(url) do
    @base_url <> url
  end

  def process_request_headers(headers) do
    custom_headers = [
      {"Content-Type", "application/json"},
      {"Authorization", @token}
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

  def async_handler(fun) do
    req =
      Task.async(fn ->
        case fun.() do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            body

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
