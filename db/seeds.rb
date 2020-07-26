# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
DiaryEntry.destroy_all
Mood.destroy_all
Activity.destroy_all

user1 = User.create(name:"Khnaittha Krajangjaem", email:"kkkk@gmail.com", username:"KhanitthaK15", password:"1115")
user2 = User.create(name:"Thorin Wilder",email:"tbtbtb@yahoo.com", username:"tbtbbus", password:"1234")

diary1 = DiaryEntry.create(content:"Today I'm Happy", user_id: user1.id)

mood1 = Mood.create(mood_name:"Happy")
mood2 = Mood.create(mood_name:"Silly")
mood3 = Mood.create(mood_name:"Good")
mood4 = Mood.create(mood_name:"Peaceful")
mood5 = Mood.create(mood_name:"Neutral")
mood6 = Mood.create(mood_name:"Angry")
mood7 = Mood.create(mood_name:"Sad")
mood8 = Mood.create(mood_name:"Stressed")
mood9 = Mood.create(mood_name:"Overwhelmed")

activity1 = Activity.create(activity_name:"Sport")
activity2 = Activity.create(activity_name:"Food")
activity3 = Activity.create(activity_name:"Work")
activity4 = Activity.create(activity_name:"School")
activity5 = Activity.create(activity_name:"Social")
activity6 = Activity.create(activity_name:"Self-Care")
activity7 = Activity.create(activity_name:"Shopping")
activity8 = Activity.create(activity_name:"Cooking")
activity9 = Activity.create(activity_name:"Entertainment")
activity10 = Activity.create(activity_name:"Travel")
activity11 = Activity.create(activity_name:"Reading")
activity12 = Activity.create(activity_name:"Relax")
activity13 = Activity.create(activity_name:"Outdoor")
activity14 = Activity.create(activity_name:"Art")
activity15 = Activity.create(activity_name:"Housework")
activity16 = Activity.create(activity_name:"Performance")
activity17 = Activity.create(activity_name:"Parenting")
activity18 = Activity.create(activity_name:"Other")





