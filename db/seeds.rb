# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "A0@itesm.mx",
    password: "shrooms4fun",
    password_confirmation: "shrooms4fun",
    admin: true
)
u.skip_confirmation!
u.save!
