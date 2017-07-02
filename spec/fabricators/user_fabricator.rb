Fabricator(:user) do
  email { Faker::Internet.email }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  zip { Faker::Address.zip }
  password { Faker::Internet.password }
end