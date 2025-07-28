# frozen_string_literal: true

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

# Create users with secure passwords (use environment variables in production)
user1 = User.create(
  name: "Khnaittha Krajangjaem", 
  email: "kkkk@gmail.com", 
  username: "KhanitthaK15", 
  password: ENV.fetch("SEED_USER1_PASSWORD", "secure_password_123")
)
user2 = User.create(
  name: "Thorin Wilder",
  email: "tbtbtb@yahoo.com", 
  username: "tbtbbus", 
  password: ENV.fetch("SEED_USER2_PASSWORD", "secure_password_456")
)

# Create moods
mood1 = Mood.create(name: "Happy", description: "Feeling joyful and content")
mood2 = Mood.create(name: "Good", description: "Feeling positive and well")
mood3 = Mood.create(name: "Calm", description: "Feeling peaceful and relaxed")
mood4 = Mood.create(name: "Cool", description: "Feeling collected and composed")
mood5 = Mood.create(name: "Angry", description: "Feeling frustrated or upset")
mood6 = Mood.create(name: "Sad", description: "Feeling down or melancholy")
mood7 = Mood.create(name: "Overwhelmed", description: "Feeling stressed or overloaded")
mood8 = Mood.create(name: "Stressed", description: "Feeling tense or anxious")

# Create activities
activity1 = Activity.create(name: "Exercise", description: "Physical activity and workouts")
activity2 = Activity.create(name: "Food", description: "Cooking and dining")
activity3 = Activity.create(name: "Work", description: "Professional activities")
activity4 = Activity.create(name: "School", description: "Educational activities")
activity5 = Activity.create(name: "Social", description: "Social interactions and events")
activity6 = Activity.create(name: "Self-Care", description: "Personal wellness activities")
activity7 = Activity.create(name: "Shopping", description: "Retail and purchasing")
activity8 = Activity.create(name: "Cooking", description: "Food preparation")
activity9 = Activity.create(name: "Entertainment", description: "Leisure and fun activities")
activity10 = Activity.create(name: "Travel", description: "Trips and journeys")
activity11 = Activity.create(name: "Reading", description: "Books and literature")
activity12 = Activity.create(name: "Relax", description: "Rest and relaxation")
activity13 = Activity.create(name: "Outdoor", description: "Outdoor activities")
activity14 = Activity.create(name: "Kids", description: "Activities with children")
activity15 = Activity.create(name: "Housework", description: "Home maintenance")
activity16 = Activity.create(name: "Other", description: "Miscellaneous activities")

puts "Database seeded successfully!"
puts "Created #{User.count} users"
puts "Created #{Mood.count} moods"
puts "Created #{Activity.count} activities"
