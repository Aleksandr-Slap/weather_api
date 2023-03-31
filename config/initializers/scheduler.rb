# frozen_string_literal: true

scheduler = Rufus::Scheduler.singleton

scheduler.interval '1h', first: 0.5 do
  CreateForecastModelJob.perform_now
end