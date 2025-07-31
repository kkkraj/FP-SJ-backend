namespace :data do
  desc "Generate realistic mood and activity data for the past 30 days for charts testing"
  task generate_chart_data: :environment do
    puts "🎯 Generating chart data for the past 30 days..."
    
    # Get user 1 (Jamie Lee)
    user = User.find_by(username: 'jlee123')
    
    unless user
      puts "❌ User 'jlee123' not found!"
      exit 1
    end
    
    puts "👤 Generating data for: #{user.name} (#{user.username})"
    
    # Get all available moods and activities
    moods = Mood.all
    activities = Activity.all
    
    puts "📊 Available moods: #{moods.count}"
    puts "🏃 Available activities: #{activities.count}"
    
    # Generate data for the past 30 days
    start_date = 30.days.ago.to_date
    end_date = Date.current
    
    puts "📅 Date range: #{start_date} to #{end_date}"
    
    # Track what we create
    mood_count = 0
    activity_count = 0
    
    # Generate data for each day
    (start_date..end_date).each do |date|
      puts "📆 Processing #{date.strftime('%Y-%m-%d')} (#{date.strftime('%A')})"
      
      # Generate 1-3 moods per day (more realistic)
      moods_per_day = rand(1..3)
      selected_moods = moods.sample(moods_per_day)
      
      selected_moods.each do |mood|
        # Create mood entry
        user_mood = UserMood.create!(
          user: user,
          mood: mood,
          mood_date: date,
          created_at: date.to_time + rand(8..20).hours + rand(0..59).minutes,
          updated_at: date.to_time + rand(8..20).hours + rand(0..59).minutes
        )
        mood_count += 1
        puts "  😊 Created mood: #{mood.mood_name}"
      end
      
      # Generate 2-5 activities per day
      activities_per_day = rand(2..5)
      selected_activities = activities.sample(activities_per_day)
      
      selected_activities.each do |activity|
        # Create activity entry with random duration
        duration = rand(15..180) # 15 minutes to 3 hours
        
        user_activity = UserActivity.create!(
          user: user,
          activity: activity,
          activity_date: date,
          duration: duration,
          created_at: date.to_time + rand(8..20).hours + rand(0..59).minutes,
          updated_at: date.to_time + rand(8..20).hours + rand(0..59).minutes
        )
        activity_count += 1
        puts "  🏃 Created activity: #{activity.activity_name} (#{duration} min)"
      end
    end
    
    puts "\n🎉 Data generation complete!"
    puts "📊 Created #{mood_count} mood entries"
    puts "🏃 Created #{activity_count} activity entries"
    puts "📅 Date range: #{start_date} to #{end_date}"
    puts "\n💡 You can now test your charts with real data!"
    puts "🔗 Login with: #{user.username} / secure_password_123"
  end
  
  desc "Clean up generated chart data (removes all user_moods and user_activities for jlee123)"
  task cleanup_chart_data: :environment do
    puts "🧹 Cleaning up generated chart data..."
    
    user = User.find_by(username: 'jlee123')
    
    unless user
      puts "❌ User 'jlee123' not found!"
      exit 1
    end
    
    # Count existing data
    existing_moods = UserMood.where(user: user).count
    existing_activities = UserActivity.where(user: user).count
    
    puts "📊 Found #{existing_moods} mood entries and #{existing_activities} activity entries"
    
    # Remove all data for this user
    UserMood.where(user: user).destroy_all
    UserActivity.where(user: user).destroy_all
    
    puts "✅ Cleaned up all chart data for #{user.name}"
    puts "💡 You can regenerate data anytime with: rails data:generate_chart_data"
  end
end 