defmodule Workpermit.PermitsTest do
  use Workpermit.DataCase

  alias Workpermit.Permits

  describe "permits" do
    alias Workpermit.Permits.Permit
    pe = %{ear_protection: nil, eyes_protection: nil, hard_hat: nil, hivis_vest: nil, id: nil, safety_boots: nil, safety_helmet: nil}
    @valid_attrs %{category: 42, closed: ~N[2010-04-17 14:00:00], controller_id: "some controller_id", finish: ~N[2010-04-17 14:00:00], issued: ~N[2010-04-17 14:00:00], issuer_id: "some issuer_id", number: 42, performer_id: "some performer_id", protective_equipment_value: pe, start: ~N[2010-04-17 14:00:00]}
    @invalid_attrs %{category: nil, closed: nil, controller_id: nil, finish: nil, issued: nil, issuer_id: nil, number: nil, performer_id: nil, protective_equipment_value: pe, start: nil}

    def permit_fixture(attrs \\ %{}) do
      {:ok, permit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Permits.create_permit()

      permit
    end

    test "list_permits/0 returns all permits" do
      permit = permit_fixture()
      assert Permits.list_permits() == [permit]
    end

    test "get_permit!/1 returns the permit with given id" do
      permit = permit_fixture()
      assert Permits.get_permit!(permit.id) == permit
    end

    test "create_permit/1 with valid data creates a permit" do
      assert {:ok, %Permit{} = permit} = Permits.create_permit(@valid_attrs)
      assert permit.category == 42
      assert permit.closed == ~N[2010-04-17 14:00:00]
      assert permit.controller_id == "some controller_id"
      assert permit.finish == ~N[2010-04-17 14:00:00]
      assert permit.issued == ~N[2010-04-17 14:00:00]
      assert permit.issuer_id == "some issuer_id"
      assert permit.number == 42
      assert permit.performer_id == "some performer_id"
      assert permit.start == ~N[2010-04-17 14:00:00]
    end

    test "create_permit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permits.create_permit(@invalid_attrs)
    end
  end
end
