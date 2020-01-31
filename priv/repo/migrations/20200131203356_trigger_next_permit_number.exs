defmodule Workpermit.Repo.Migrations.TriggerNextPermitNumber do
  use Ecto.Migration

  def up do
    execute "CREATE TRIGGER update_next_permit_number BEFORE INSERT ON PERMITS FOR EACH ROW EXECUTE PROCEDURE next_permit();"
  end

  def down do
    execute "DROP TRIGGER IF EXISTS update_next_permit_number ON permits;"
  end
end
