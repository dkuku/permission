# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Workpermit.Repo.insert!(%Workpermit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
Enum.each(1..20, fn(id) ->
  Workpermit.Accounts.create_user(%{
    email: Faker.Internet.email(),
    password: "qweasd",
    first_name: Faker.Name.first_name(),
    last_name: Faker.Name.last_name(),
    phone: Faker.Phone.EnGb.number()
  })
end)
