# Skip asset precompilation for API-only Rails app
namespace :assets do
  task :precompile do
    puts "Skipping asset precompilation for API-only Rails app"
  end
end
