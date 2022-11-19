# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(email: "super_admin@dev.com", fullname: "Admin", password: "password", password_confirmation: "password", role: "system_admin")
Admin.create!(:username => "admin", :password => "password", :password_confirmation => "password", :first_name => "amjad", :middle_name => "sample", :last_name => "yassin", :gender => "male")


# Staff.create!(:username => "wade123", :password => "password", :password_confirmation => "password", :first_name => "janice", :middle_name => "fortuna",
#       :last_name => "wade", :email => "wade123@gmail.com", :gender => "female", curriculum_id: 3, college_id: 1 )

# Student.create!(:username => "yassin123", :password => "password", :password_confirmation => "password", :first_name => "amjad", :middle_name => "sample",
#       :last_name => "yassin", :email => "yassinstudent@gmail.com", :gender => "male", id_number: 201574858, adviser_id: 1, curriculum_id: 3, college_id: 1 )

