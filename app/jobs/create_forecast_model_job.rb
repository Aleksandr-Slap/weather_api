class CreateForecastModelJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ForecastCreateService.call
  end
end
