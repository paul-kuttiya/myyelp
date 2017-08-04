Fabricate(:user,
  first_name: 'admin',
  last_name: 'admin',
  email: 'admin@email.com',
  password: 'admin',
)

10.times do
  Fabricate(:user)
  Fabricate(:business)
end

100.times do
  Fabricate(:review)
end

Review.all.each do |r|
  n = (1..365).to_a.sample
  r.update(created_at: n.days.ago) if r.id != 1
end