module Weather
  class WeatherController < ApplicationController

    include HTTParty

    CURRENT_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212?#{ENV.fetch('API_KEY_WEATHER')}".freeze


    def current
      response = HTTParty.get(CURRENT_WEATHER_URL)
      body = JSON.parse(response.body)
      value = body[0]['Temperature']['Metric']['Value']

      render json: value
    end  
  end
end