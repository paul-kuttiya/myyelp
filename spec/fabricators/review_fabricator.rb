Fabricator(:review) do
  rating { (1..5).to_a.sample }
  business { Business.all.sample }
  user { User.all.sample }
  description { Faker::Lorem.paragraph(50) }
end