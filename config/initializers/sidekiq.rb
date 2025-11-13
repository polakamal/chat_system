require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  schedule_file = Rails.root.join("config/sidekiq_schedule.yml")
  if File.exist?(schedule_file)
    schedule = YAML.load_file(schedule_file)
    # Convert keys to symbols (important!)
    Sidekiq.schedule = schedule.transform_keys(&:to_sym)
    Sidekiq::Scheduler.enabled = true
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end
