defmodule Workpermit.PermitsTest do
  use Workpermit.DataCase

  alias Workpermit.Permits
  alias Workpermit.Permits.Permit
  import Workpermit.Factory

  @invalid_attrs %{
     category: nil,
     closed: :nil,
     controller_id: :nil,
     finish: :nil,
     issued: :nil,
     issuer_id: :nil,
     number: :nil,
     performer_id: :nil,
     protective_equipment: :nil,
    start: :nil
  }
  #TODO check these inserts - conert to build
  @valid_attrs %{
     category: 42,
     closed: ~N[2010-04-17 14:00:00],
     controller_id: build(:user),
     finish: ~N[2010-04-17 14:00:00],
     issued: ~N[2010-04-17 14:00:00],
     issuer: build(:user),
     number: 42,
     performer: build(:user),
     firewatch: build(:user),
     protective_equipment: build(:protective_equipment),
    start: ~N[2010-04-17 14:00:00]
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
      assert permit_db.closed == permit.closed 
      assert permit_db.finish == permit.finish
      assert permit_db.issued == permit.issued
    end

    test "create_permit/1 with valid data creates a permit" do
      assert {:ok, %Permit{} = permit} = Permits.create_permit(@valid_attrs)
      assert permit.category == 42
      assert permit.closed == ~N[2010-04-17 14:00:00]
      assert permit.finish == ~N[2010-04-17 14:00:00]
      assert permit.issued == ~N[2010-04-17 14:00:00]
      assert permit.number == 42
      assert permit.start == ~N[2010-04-17 14:00:00]
    end

    test "create_permit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permits.create_permit(@invalid_attrs)
    end
  end
end
