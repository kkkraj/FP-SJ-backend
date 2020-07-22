# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

user1 = User.create(name:"Khnaittha Krajangjaem", email:"kkkk@gmail.com", username:"KhanitthaK15", password:"1115")
user2 = User.create(name:"Thorin Wilder",email:"tbtbtb@yahoo.com", username:"tbtbbus", password:"1234")

diary1 = DiaryEntry.create(content:"Today I'm Happy", user_id: user2.id)

