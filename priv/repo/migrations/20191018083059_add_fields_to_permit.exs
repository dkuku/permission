defmodule Workpermit.Repo.Migrations.AddFieldsToPermit do
  use Ecto.Migration

  def change do
    alter table("permits") do
      add_if_not_exists :organisation, :integer
      add_if_not_exists :issuer_name, :string
      add_if_not_exists :controller_name, :string
      add_if_not_exists :firewatch_name, :string
      add_if_not_exists :performer_name, :string
      add_if_not_exists :precautions, :string
      add_if_not_exists :coshh, :string
      add_if_not_exists :lone_working, :boolean
      add_if_not_exists :additional_info, :boolean
      remove_if_exists :controller_id, :integer
      remove_if_exists :firewatch_id, :integer
      remove_if_exists :performer_id, :integer
    end
    rename table("permits"), :start, to: :start_time
    rename table("permits"), :closed, to: :closed_time
    rename table("permits"), :finish, to: :finish_time
    rename table("permits"), :issued, to: :issued_time
  end
end
