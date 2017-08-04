require 'json'

Fabricator(:business) do
  name { Faker::Lorem.words(2).join(' ') }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state_abbr }
  zip { Faker::Address.zip }
  phone { Faker::PhoneNumber.cell_phone }
  photo { get_image }
end

def get_image
  file = File.read('./business_image_endpoint.json')
  data = JSON.parse(file)
  data.sample
end