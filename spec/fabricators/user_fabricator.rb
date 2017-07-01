Fabricator(:user) do
  email {Faker::Internet.email}
  first_name {Faker::Name.name}
  last_name {Faker::Name.name}
  zip "12345"
  password "password"
end