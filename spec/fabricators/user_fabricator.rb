Fabricator(:user) do
  email { Faker::Internet.email }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  zip { Faker::Address.zip }
  password { Faker::Internet.password }
  # photo { Faker::Avatar.image(sample_slug, "50x50", "png", "set#{sample_num(1, 4)}", "bg#{sample_num(1, 4)}") }  
  photo { "https://randomuser.me/api/portraits/#{gender}/#{sample_num(1, 99)}.jpg" }
end

def gender
  ['men', 'women'].sample
end

# def sample_slug
#   SecureRandom.hex(5)
# end

def sample_num(start, final)
  (start..final).to_a.sample
end