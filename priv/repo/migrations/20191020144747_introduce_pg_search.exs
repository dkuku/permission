defmodule Workpermit.Repo.Migrations.IntroducePgSearch do
  @moduledoc """
  Create postgres extension and indices
  """

  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION pg_trgm")

    execute("""
    CREATE INDEX users_trgm_idx ON users USING GIN (to_tsvector('english',
      first_name || ' ' || coalesce(last_name, ' '))
    """)
  end

  def down do
    execute("DROP INDEX users_trgm_idx")
    execute("DROP EXTENSION pg_trgm")
  end
end
