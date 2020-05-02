defmodule Web.PdfGenerator do
  import Plug.Conn
  import Plug.Upload

  @wkhtmltopdf_path System.find_executable("wkhtmltopdf")

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    generate_pdf(conn, opts)
    #    case Regex.match?(~r/.*(pdf)$/, conn.request_path) do
    #      true -> generate_pdf(conn, opts)
    #      false -> conn
    #    end
  end

  defp generate_pdf(conn, opts) do
    url = "#{conn.scheme}://#{conn.host}:#{conn.port}#{conn.request_path}"
    {:ok, file} = random_file("test")
    conn = fetch_cookies(conn)

    args =
      ["-q"] ++
        join_cookies(conn.req_cookies) ++
        join_options(opts) ++ [String.replace(url, "/pdf", ""), file]

    IO.inspect(args)
    System.cmd(@wkhtmltopdf_path, args)

    conn
    |> put_resp_content_type("application/pdf")
    #         |> render("pdf.html", data: body)
    |> send_file(200, file)
    |> halt
  end

  defp join_cookies(cookies) when cookies == %{}, do: []

  defp join_cookies(cookies) do
    cookies
    |> Enum.map(fn {k, v} -> ["--cookie", "#{k}", "#{URI.encode(v)}"] end)
    |> List.flatten()
  end

  defp join_options(options) do
    options
    |> Enum.map(fn {k, v} -> ["--#{k}", "#{v}"] end)
    |> List.flatten()
  end
end
