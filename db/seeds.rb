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
Goal.destroy_all
Gratitude.destroy_all
JournalPrompt.destroy_all

# Create users with secure passwords (use environment variables in production)
user1 = User.create(
  name: "Jamie L.", 
  email: "quiet.pages@example.com", 
  password: ENV.fetch("SEED_USER1_PASSWORD", "secure_password_123")
)
user2 = User.create(
  name: "Alex Ray",
  email: "alex.ray@example.com", 
  password: ENV.fetch("SEED_USER2_PASSWORD", "secure_password_456")
)

# Create moods
mood1 = Mood.create(mood_name: "Happy", mood_url: "https://i.imgur.com/itD13Tf.png")
mood2 = Mood.create(mood_name: "Good", mood_url: "https://i.imgur.com/rkVgnSl.png")
mood3 = Mood.create(mood_name: "Calm", mood_url: "https://i.imgur.com/K7Vhmij.png")
mood4 = Mood.create(mood_name: "Cool", mood_url: "https://i.imgur.com/tHXVEnN.png")
mood5 = Mood.create(mood_name: "Angry", mood_url: "https://i.imgur.com/WNczyw3.png")
mood6 = Mood.create(mood_name: "Sad", mood_url: "https://i.imgur.com/y8PbDup.png")
mood7 = Mood.create(mood_name: "Overwhelmed", mood_url: "https://i.imgur.com/vQinwp8.png")
mood8 = Mood.create(mood_name: "Stressed", mood_url: "https://i.imgur.com/3q0xzl3.png")

# Create activities
activity1 = Activity.create(activity_name: "Exercise", activity_url: "https://i.imgur.com/3I65ivR.png")
activity2 = Activity.create(activity_name: "Food", activity_url: "https://i.imgur.com/rFY4EPt.png")
activity3 = Activity.create(activity_name: "Work", activity_url: "https://i.imgur.com/Mm81ZjJ.png")
activity4 = Activity.create(activity_name: "School", activity_url: "https://i.imgur.com/BeHs4k1.png")
activity5 = Activity.create(activity_name: "Social", activity_url: "https://i.imgur.com/wE4fGdx.png")
activity6 = Activity.create(activity_name: "Self-Care", activity_url: "https://i.imgur.com/VAQRWTv.png")
activity7 = Activity.create(activity_name: "Shopping", activity_url: "https://i.imgur.com/HlHEBEf.png")
activity8 = Activity.create(activity_name: "Cooking", activity_url: "https://i.imgur.com/NPumLVA.png")
activity9 = Activity.create(activity_name: "Entertainment", activity_url: "https://i.imgur.com/3laGTKH.png")
activity10 = Activity.create(activity_name: "Travel", activity_url: "https://i.imgur.com/6yaGHE1.png")
activity11 = Activity.create(activity_name: "Reading", activity_url: "https://i.imgur.com/VpJTway.png")
activity12 = Activity.create(activity_name: "Relax", activity_url: "https://i.imgur.com/EByeg2y.png")
activity13 = Activity.create(activity_name: "Outdoor", activity_url: "https://i.imgur.com/K14KMSt.png")
activity14 = Activity.create(activity_name: "Kids", activity_url: "https://i.imgur.com/0qPOr0y.png")
activity15 = Activity.create(activity_name: "Housework", activity_url: "https://i.imgur.com/q08KUEx.png")
activity16 = Activity.create(activity_name: "Other", activity_url: "https://i.imgur.com/Hc3X0eT.png")

# Create goals
goals = [
  { title: "Exercise for 30 minutes", category: "health", description: "Physical activity goal" },
  { title: "Read for 20 minutes", category: "learning", description: "Reading goal" },
  { title: "Meditate for 10 minutes", category: "mindfulness", description: "Meditation goal" },
  { title: "Call a friend", category: "social", description: "Social connection goal" },
  { title: "Complete work project", category: "work", description: "Work productivity goal" },
  { title: "Eat 5 servings of vegetables", category: "health", description: "Nutrition goal" },
  { title: "Get 8 hours of sleep", category: "health", description: "Sleep goal" },
  { title: "Learn something new", category: "learning", description: "Personal growth goal" }
]

goals.each do |goal_data|
  Goal.create(goal_data)
end

# Create gratitudes
gratitudes = [
  { title: "Family support", category: "relationships", description: "Gratitude for family" },
  { title: "Good health", category: "health", description: "Gratitude for health" },
  { title: "Job security", category: "work", description: "Gratitude for work" },
  { title: "Beautiful weather", category: "nature", description: "Gratitude for nature" },
  { title: "Learning something new", category: "growth", description: "Gratitude for growth" },
  { title: "Friendship", category: "relationships", description: "Gratitude for friends" },
  { title: "A safe home", category: "security", description: "Gratitude for shelter" },
  { title: "Delicious food", category: "comfort", description: "Gratitude for nourishment" }
]

gratitudes.each do |gratitude_data|
  Gratitude.create(gratitude_data)
end

# Create journal prompts
journal_prompts = [
  { question: "What was the best part of your day?", category: "reflection", description: "Daily reflection prompt" },
  { question: "What are you looking forward to tomorrow?", category: "future", description: "Future planning prompt" },
  { question: "What challenge did you overcome today?", category: "growth", description: "Personal growth prompt" },
  { question: "How did you show kindness today?", category: "values", description: "Values reflection prompt" },
  { question: "What made you smile today?", category: "joy", description: "Joy reflection prompt" },
  { question: "What are you grateful for right now?", category: "gratitude", description: "Gratitude prompt" },
  { question: "What would you like to improve about yourself?", category: "growth", description: "Self-improvement prompt" },
  { question: "Describe a moment when you felt proud of yourself.", category: "achievement", description: "Achievement prompt" }
]

journal_prompts.each do |prompt_data|
  JournalPrompt.create(prompt_data)
end

puts "Database seeded successfully!"
puts "Created #{User.count} users"
puts "Created #{Mood.count} moods"
puts "Created #{Activity.count} activities"
puts "Created #{Goal.count} goals"
puts "Created #{Gratitude.count} gratitudes"
puts "Created #{JournalPrompt.count} journal prompts"
