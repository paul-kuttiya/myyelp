Fabricator(:business) do
  name { Faker::Lorem.words(2).join(' ') }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  zip { Faker::Address.zip }
  phone { Faker::PhoneNumber.cell_phone }
end