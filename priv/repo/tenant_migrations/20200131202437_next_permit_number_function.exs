defmodule Workpermit.Repo.Migrations.NextPermitNumberFunction do
  use Ecto.Migration

  def up do
    execute """
    CREATE OR REPLACE FUNCTION #{prefix()}_next_permit()
    RETURNS TRIGGER AS $category_number$ 
      BEGIN 
        SELECT coalesce(max(number), 0)+1 INTO NEW.number 
          FROM #{prefix()}.permits WHERE category = NEW.category;   
        RETURN NEW; 
      END; 
    $category_number$ LANGUAGE plpgsql;
    """
  end

  def down do
    execute "DROP FUNCTION IF EXISTS #{prefix()}_next_permit() CASCADE;"
  end
end
