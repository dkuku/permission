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
     issuer_name: :nil,
     number: :nil,
     performer_name: :nil,
     protective_equipment: :nil,
    start_time: :nil
  }
  #TODO check these inserts - conert to build
  @valid_attrs %{
    category: :heights,
     number: 42,
     closed_time: ~N[2010-04-17 14:00:00],
     start_time: ~N[2010-04-17 14:00:00],
     finish_time: ~N[2010-04-17 14:00:00],
     issuer_name: "Issuer Name",
     controller_name: "Controller Name",
     performer_name: "Performer Name",
     firewatch_name: "Firewatch Name",
     issuer: build(:user),
     protective_equipment: ~w(dust_mask),
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
    end

    test "create_permit/1 with valid data creates a permit" do
      user = build(:user)
      assert {:ok, %Permit{} = permit} = Permits.create_permit(user, @valid_attrs)
      assert permit.category == :heights
      assert permit.number == 42
      assert permit.closed_time == ~N[2010-04-17 14:00:00]
      assert permit.finish_time == ~N[2010-04-17 14:00:00]
      assert permit.start_time == ~N[2010-04-17 14:00:00]
    end

    test "create_permit/1 with invalid data returns error changeset" do
      user = build(:user)
      assert {:error, %Ecto.Changeset{}} = Permits.create_permit(user, @invalid_attrs)
    end

    test "category_fields/1 returns all categories" do
      assert [:general, :electrical, :heights, :hot_work, :confined_space, :hot_fluid, :gas] = Permits.category_fields()
    end
    
    test "pe_fields/1 returns all protective_equipment fields" do
      pe = Permits.pe_fields()
      assert length(pe) == 12
      [first | _rest] = pe
      assert first == :ear_protection
    end

    @tag :skip
    test "next_permit_number/1 returns number + 1 of ladt permit in category" do
      next_electrical = Permits.next_permit_number(:electrical)
      _permit = insert(:permit, %{:category  => :electrical})
      assert Permits.next_permit_number(:electrical) == next_electrical + 1
    end
  end
end
