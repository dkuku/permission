defmodule Workpermit.Repo.Migrations.TriggerNextPermitNumber do
  use Ecto.Migration

  def up do
    execute "CREATE TRIGGER #{prefix()}_update_next_permit_number BEFORE INSERT ON #{prefix()}.permits
    FOR EACH ROW EXECUTE PROCEDURE #{prefix()}_next_permit();"
  end

  def down do
    execute "DROP TRIGGER IF EXISTS #{prefix()}_update_next_permit_number ON #{prefix()}.permits;"
  end
end
