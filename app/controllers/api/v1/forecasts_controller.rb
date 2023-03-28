# frozen_string_literal: true

module Api
  module V1
    class ForecastsController < ApplicationController

      CURRENT_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212?#{ENV.fetch('API_KEY_WEATHER')}"
      
      def current
        respon_body = JSON.parse(HTTParty.get(CURRENT_WEATHER_URL).body)

        render json: respon_body[0]["Temperature"]["Metric"]["Value"]
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
        arr = Forecast.last.history.map do |hour|
                hour["temp"] if hour["time"] == Time.at(params[:timestamp].to_i).to_time.beginning_of_hour.to_s
              end
        respone = arr.compact.empty? ? "404 Not Found" : arr.compact

        render json: respone[0].to_s
      end 
    end
  end
end
        
