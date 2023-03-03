module Weather
  module Historical
    class WeatherController < ApplicationController

      include HTTParty

      CURRENT_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212?#{ENV.fetch('API_KEY_WEATHER')}".freeze
      HISTORY_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212/historical/24?#{ENV.fetch('API_KEY_WEATHER')}".freeze


      def current
        response = HTTParty.get(CURRENT_WEATHER_URL)
        body = JSON.parse(response.body)
        current_temp = body[0]['Temperature']['Metric']['Value']  #Экшн перенесён в controller/weather/weather_controller

        render json: current_temp
      end

      def historical
        response = HTTParty.get(HISTORY_WEATHER_URL)
        body = JSON.parse(response.body)
        hourly_temp = {}
        body.each { |e| hourly_temp[e['LocalObservationDateTime'].to_time] =e['Temperature']['Metric']['Value'] }
        
        render json: hourly_temp
      end

      def temp_max
        render json: "#{ENV}".class
      end  
    end
  end
end
