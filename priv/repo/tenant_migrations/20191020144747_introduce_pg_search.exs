defmodule Workpermit.Repo.Migrations.IndexPgsearch do
  @moduledoc """
  Create postgres extension and indices
  """

  use Ecto.Migration

  def up do
    execute("""
    CREATE INDEX users_trgm_idx ON #{prefix()}.users USING GIN (to_tsvector('english', first_name || ' ' || coalesce(last_name, ' ')));
    """)
  end

  def down do
    execute("DROP INDEX users_trgm_idx")
  end
end
