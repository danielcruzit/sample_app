
User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    phone_number: "123123123",
    password:              "foobar",
    password_confirmation: "foobar"
    admin:true)
# Generate a bunch of additional users.
99.times do |n|
    name = n+1
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