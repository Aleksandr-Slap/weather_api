# frozen_string_literal: true

class ForecastCreateService < BaseService

  include HTTParty  

  HISTORY_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212/historical/24?#{ENV.fetch('API_KEY_WEATHER')}"

  def call
    history = weather_history_in_24_hours

    Forecast.create!(
      max: max_temp(history),
      min: min_temp(history),
      avg: avg_temp(history).round(1),
      history: history
    )
  end

  private

  def weather_history_in_24_hours
    JSON.parse(HTTParty.get(HISTORY_WEATHER_URL).body).map do |hour|
      { time: hour["LocalObservationDateTime"].to_time.beginning_of_hour, temp: hour["Temperature"]["Metric"]["Value"]}
    end  
  end

  def max_temp(history)
    history.map { _1[:temp] }.max
  end 

  def min_temp(history)
    history.map { _1[:temp] }.min
  end

  def avg_temp(history)
    history.map {_1[:temp] }.sum / history.size
  end
end