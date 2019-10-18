defmodule Workpermit.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Workpermit.Repo


  def user_factory do
    %Workpermit.Accounts.User{
      first_name: "Jane",
      last_name: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      phone: sequence(:phone, &"077123456#{&1}"),
      password: "12345asd",
    }
  end

  def protective_equipment_factory do
    %Workpermit.Permits.ProtectiveEquipment{
      mask: :true,
    }
  end

  def permit_factory do
    %Workpermit.Permits.Permit{
   category: 2,
   number: sequence(:number, &(&1)),
   closed_time: ~N[2010-04-17 14:00:00],
   finish_time: ~N[2010-04-17 14:00:00],
   issued_time: ~N[2010-04-17 14:00:00],
   start_time: ~N[2010-04-17 14:00:00],
   issuer: build(:user),
   issuer_name: "Issuer Name",
   controller_name: "Controller Name",
   firewatch_name: "Firewatch Name",
   performer_name: "Performer Name",
   protective_equipment: build(:protective_equipment),
   precautions: "# precautions",
   additional_info: "Additional info",
    }
  end
end
