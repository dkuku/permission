defmodule Workpermit.Repo.Migrations.RenamePassword do
  use Ecto.Migration

  def change do
    rename table(:users), :encrypted_password, to: :password_hash
  end
end
