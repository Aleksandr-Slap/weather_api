# frozen_string_literal: true

class CreateForecastModelJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    ForecastCreateService.call
  end
end
