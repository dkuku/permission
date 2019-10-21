
defmodule Workpermit.ProtectiveEquipmentTest do
  use Workpermit.DataCase

  alias Workpermit.Permits

  describe "protective_equipment" do
    alias Workpermit.Permits.ProtectiveEquipment
    @valid_attrs %{
      ear_protection: :true,
      earth_terminal: :true,
      eye_protection: :true,
      face_shield: :true,
      foot_protection: :true,
      head_protection: :true,
      high_visibility_clothing: :true,
      mask: :true,
      safety_harness: :true,
      welding_mask: :true,
      protective_gloves: :true,
      protective_clothing: :true,
    }
    @invalid_attrs %{
      ear_protection: :nil,
      earth_terminal: :nil,
      eye_protection: :nil,
      face_shield: :nil,
      foot_protection: :nil,
      head_protection: :nil,
      high_visibility_clothing: :nil,
      mask: :nil,
      safety_harness: :nil,
      welding_mask: :nil,
      protective_gloves: :nil,
      protective_clothing: :nil,
    }
    def protective_equipment_fixture(attrs \\ %{}) do
      {:ok, protective_equipment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Permits.create_protective_equipment()

      protective_equipment
    end

    def pe_fields do
      #set it as an org param
      assert ProtectiveEquipment.keys() == 1
    end

    test "get_protective_equipment!/1 returns the protective_equipment with given id" do
      protective_equipment = protective_equipment_fixture()
      assert Permits.get_protective_equipment(protective_equipment.id) == protective_equipment
    end

    test "create_protective_equipment/1 with valid data creates a protective_equipment" do
      assert {:ok, %ProtectiveEquipment{} = protective_equipment} = Permits.create_protective_equipment(@valid_attrs)
      assert protective_equipment.ear_protection == :true
      assert protective_equipment.earth_terminal == :true
      assert protective_equipment.eye_protection == :true
      assert protective_equipment.face_shield == :true
      assert protective_equipment.foot_protection == :true
      assert protective_equipment.head_protection == :true
      assert protective_equipment.high_visibility_clothing == :true
      assert protective_equipment.mask == :true
      assert protective_equipment.safety_harness == :true
      assert protective_equipment.welding_mask == :true
      assert protective_equipment.protective_gloves == :true
    end
    test "create_protective_equipment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permits.create_protective_equipment(@invalid_attrs)
    end
  end
end
