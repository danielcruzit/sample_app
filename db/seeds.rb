
User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    phone_number: "123123123",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: "true" )
# Generate a bunch of additional users.
99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org" 
    password = "password"
    phone_number = (1..9).to_a.map do |t| t= rand(9) end.join.to_s
    User.create!(name: name,
                email: email,
                phone_number: phone_number,
                password:              password,
                password_confirmation: password
            )
end


# Generate microposts for a subset of users. 
users = User.order(:created_at).take(6)
50.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.microposts.create!(content: content) }
end


# Create following relationships.
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }