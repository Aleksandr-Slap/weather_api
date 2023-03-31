# frozen_string_literal: true

module Api
  module V1
    class ForecastsController < ApplicationController
      CURRENT_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212?#{ENV.fetch('API_KEY_WEATHER')}"
      
      def current
        respon_body = JSON.parse(HTTParty.get(CURRENT_WEATHER_URL).body)

        render json: respon_body[0]['Temperature']['Metric']['Value']
      end

      def temp_max
        render json: Forecast.last.max
      end

      def temp_min
        render json: Forecast.last.min
      end

      def temp_average
        render json: Forecast.last.avg
      end

      def historical
        render json: Forecast.last.history
      end

      def by_time
        temp_by_time = Forecast
                       .last
                       .history
                       .select { _1['time'] == Time.at(params[:timestamp].to_i).to_time.beginning_of_hour.to_s }
        
        render json: temp_by_time.empty? ? '404 Not Found' : temp_by_time[0]['temp']
      end
    end
  end
end
