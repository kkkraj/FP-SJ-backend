# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Mood.destroy_all
Activity.destroy_all

user1 = User.create(name:"Khnaittha Krajangjaem", email:"kkkk@gmail.com", username:"KhanitthaK15", password:"1115")
user2 = User.create(name:"Thorin Wilder",email:"tbtbtb@yahoo.com", username:"tbtbbus", password:"1234")

mood1 = Mood.create(mood_name:"Happy", mood_url:"https://i.imgur.com/itD13Tf.png")
mood2 = Mood.create(mood_name:"Good", mood_url:"https://i.imgur.com/rkVgnSl.png")
mood3 = Mood.create(mood_name:"Calm", mood_url:"https://i.imgur.com/K7Vhmij.png")
mood4 = Mood.create(mood_name:"Cool", mood_url:"https://i.imgur.com/tHXVEnN.png")
mood5 = Mood.create(mood_name:"Angry", mood_url:"https://i.imgur.com/WNczyw3.png")
mood6 = Mood.create(mood_name:"Sad", mood_url:"https://i.imgur.com/y8PbDup.png")
mood7 = Mood.create(mood_name:"Overwhelmed", mood_url:"https://i.imgur.com/vQinwp8.png")
mood8 = Mood.create(mood_name:"Stressed", mood_url:"https://i.imgur.com/3q0xzl3.png")

activity1 = Activity.create(activity_name:"Exercise", activity_url:"https://i.imgur.com/3I65ivR.png")
activity2 = Activity.create(activity_name:"Food", activity_url:"https://i.imgur.com/rFY4EPt.png")
activity3 = Activity.create(activity_name:"Work", activity_url:"https://i.imgur.com/Mm81ZjJ.png")
activity4 = Activity.create(activity_name:"School", activity_url:"https://i.imgur.com/BeHs4k1.png")
activity5 = Activity.create(activity_name:"Social", activity_url:"https://i.imgur.com/wE4fGdx.png")
activity6 = Activity.create(activity_name:"Self-Care", activity_url:"https://i.imgur.com/VAQRWTv.png")
activity7 = Activity.create(activity_name:"Shopping", activity_url:"https://i.imgur.com/HlHEBEf.png")
activity8 = Activity.create(activity_name:"Cooking", activity_url:"https://i.imgur.com/NPumLVA.png")
activity9 = Activity.create(activity_name:"Entertainment", activity_url:"https://i.imgur.com/3laGTKH.png")
activity10 = Activity.create(activity_name:"Travel", activity_url:"https://i.imgur.com/6yaGHE1.png")
activity11 = Activity.create(activity_name:"Reading", activity_url:"https://i.imgur.com/VpJTway.png")
activity12 = Activity.create(activity_name:"Relax", activity_url:"https://i.imgur.com/EByeg2y.png")
activity13 = Activity.create(activity_name:"Outdoor", activity_url:"https://i.imgur.com/K14KMSt.png")
activity14 = Activity.create(activity_name:"Kids", activity_url:"https://i.imgur.com/0qPOr0y.png")
activity15 = Activity.create(activity_name:"Housework", activity_url:"https://i.imgur.com/q08KUEx.png")
activity16 = Activity.create(activity_name:"Other", activity_url:"https://i.imgur.com/Hc3X0eT.png")
