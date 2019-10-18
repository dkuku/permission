defmodule Workpermit.PermitsTest do
  use Workpermit.DataCase

  alias Workpermit.Permits
  alias Workpermit.Permits.Permit
  import Workpermit.Factory

  @invalid_attrs %{
     category: nil,
     closed: :nil,
     controller_name: :nil,
     finish_time: :nil,
     issued_time: :nil,
     issuer_name: :nil,
     number: :nil,
     performer_name: :nil,
     protective_equipment: :nil,
    start_time: :nil
  }
  #TODO check these inserts - conert to build
  @valid_attrs %{
     category: 42,
     number: 42,
     closed_time: ~N[2010-04-17 14:00:00],
     start_time: ~N[2010-04-17 14:00:00],
     finish_time: ~N[2010-04-17 14:00:00],
     issued_time: ~N[2010-04-17 14:00:00],
     issuer_name: "Issuer Name",
     controller_name: "Controller Name",
     performer_name: "Performer Name",
     firewatch_name: "Firewatch Name",
     issuer: build(:user),
     protective_equipment: build(:protective_equipment),
  }

  describe "permits" do

    test "list_permits/0 returns all permits" do
      insert_list(3, :permit)
      assert length(Permits.list_permits()) == 3
    end

    test "get_permit!/1 returns the permit with given id" do
      permit = insert(:permit)
      permit_db = Permits.get_permit!(permit.id)
      assert permit_db.id == permit.id
      assert permit_db.number == permit.number
      assert permit_db.category == permit.category
      assert permit_db.closed_time == permit.closed_time 
      assert permit_db.finish_time == permit.finish_time
      assert permit_db.issued_time == permit.issued_time
    end

    test "create_permit/1 with valid data creates a permit" do
      assert {:ok, %Permit{} = permit} = Permits.create_permit(@valid_attrs)
      assert permit.category == 42
      assert permit.number == 42
      assert permit.closed_time == ~N[2010-04-17 14:00:00]
      assert permit.finish_time == ~N[2010-04-17 14:00:00]
      assert permit.issued_time == ~N[2010-04-17 14:00:00]
      assert permit.start_time == ~N[2010-04-17 14:00:00]
    end

    test "create_permit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permits.create_permit(@invalid_attrs)
    end
  end
end
