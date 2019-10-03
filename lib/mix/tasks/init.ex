defmodule Mix.Tasks.Init do
  use Mix.Task

  @moduledoc false

  def run(_) do
    "Setting up Git Hooks" |> IO.puts()
    System.cmd("mkdir", [".githooks"])
    System.cmd("chmod", ["-v", "-R", "+x", ".githooks"])
    System.cmd("git", ["config", "core.hooksPath", ".githooks"])
  end
end
