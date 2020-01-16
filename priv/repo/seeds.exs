
Enum.each(1..60, fn(_id) ->
  Workpermit.Accounts.create_user(%{
    email: Faker.Internet.email(),
    password: "qweasd",
    first_name: Faker.Name.first_name(),
    last_name: Faker.Name.last_name(),
    phone: Faker.Phone.EnGb.number()
  })
end)

{:ok, user} = Workpermit.Accounts.create_user(%{
  email: Faker.Internet.email(),
  password: "qweasd",
  first_name: Faker.Name.first_name(),
  last_name: Faker.Name.last_name(),
  phone: Faker.Phone.EnGb.number()
})
Enum.each(1..100, fn(id) ->
  permit = Workpermit.Permits.create_permit(%{
    category: rem(id, 5),
    number: id,
    start_time: ~N[2020-01-21 06:00:00],
    closed_time: ~N[2020-01-21 12:00:00],
    finish_time: ~N[2020-01-21 14:00:00],
    issuer: user,
    issuer_id: user.id,
    issuer_name: "Issuer Name",
    controller_name: "Controller Name",
    firewatch_name: "Firewatch Name",
    performer_name: "Performer Name",
    protective_equipment: [
      :safety_harness,
      :welding_mask,
      ;protective_gloves,
    ],
    precautions: """
              # Harundine more novercae

              ## Resolvite obest necem

                  Lorem markdownum, nomen qui unda dedit posuit otia; fert ante sed fratres altis. Hortaturque facta cervix clarum feres ire seque serosque precantem crimine tauri, Laestrygonis. Ausa dare parentum confertur in servet mella; sit dictis moenia ambiguus ad victus fudit consurgere peregerit nutrix.

              - E foedere fateri
              - Res aut ab parvi ut diligitur talem
              - Licha Scirone
              - Satia rupe

              ## Dicenti si iniqua Numam

                  Ramos profatur: subiecit oves. Verba robora forsitan stillanti tutae adest et prece: iuvenem, brevis tulit lingua. Exaudi et ante et per ego letalis medio violentus agros tinxerat non.

                  Pedum parabant oblitus dicens circumspicit Lycormas si inter secunda vacuos, deum auctus Athin mitissimus mentes furta resolvit votisque. Numinis madida Crenaee iam.

              ## Est munus decimo et algae me animos
              """,
  additional_info: """
                    ## Recumbere strepitans alienaque aequore

                    Tori nam hostem ratem nefas vocassent mutatur perde, inde tremula: recingunt animum Troiae lunae. Non nova fusus: numen aequoreae Ciconum murmura et in. Digna est dixere serta dicet: audenti caelum feci sorbentur rogos manu prioribus leaena munus. Umbram aetatis quo Alcyone cultosque e flammas cauti, quo Phoebo prunaque Priamum Bistoniis inmensum situs. Rapi consanguineas annum sacrificos in cum: futurus multae et sic sit, at.

                    - Veris ureris
                    - Achilles plura
                    - Talia tellurem culmine
                    - Inritata non fert percussis fassusque flore praecipiti
                    - Gradu ipsius per fuerat part
                    """
  })
  IO.inspect permit
end)
