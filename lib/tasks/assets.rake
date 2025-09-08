# Skip asset precompilation for API-only Rails app
if Rails.application.config.api_only
  Rake::Task["assets:precompile"].clear
  namespace :assets do
    task :precompile do
      puts "Skipping asset precompilation for API-only Rails app"
    end
  end
end
