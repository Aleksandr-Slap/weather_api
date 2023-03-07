# frozen_string_literal: true

module Api
  module V1
    class WeatherController < ApplicationController
      include HTTParty  

      CURRENT_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212?#{ENV.fetch('API_KEY_WEATHER')}".freeze
      HISTORY_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212/historical/24?#{ENV.fetch('API_KEY_WEATHER')}".freeze

      def current
        response = HTTParty.get(CURRENT_WEATHER_URL)
        respone_body = JSON.parse(response.body)
        current_temp = respone_body[0]['Temperature']['Metric']['Value']

        render json: current_temp
      end

      def historical
        request_response
        hourly_temp = {}
        @respone_body.each { hourly_temp[_1['LocalObservationDateTime'].to_time] = _1['Temperature']['Metric']['Value'] }

        render json: hourly_temp
      end

      def temp_max
        request_response
        get_hourly_temperature

        render json: @all_temp.max
      end

      def temp_min
        request_response
        get_hourly_temperature

        render json: @all_temp.min
      end

      def temp_average
        request_response
        get_hourly_temperature
        average_temp = @all_temp.sum / @all_temp.length

        render json: average_temp.round(1)
      end

      def by_time
        render json: Time.at(params[:timestamp].to_i)
      end 

      private

      def request_response 
        response = HTTParty.get(HISTORY_WEATHER_URL)
        @respone_body = JSON.parse(response.body)
      end

      def get_hourly_temperature
        @all_temp = []
        @respone_body.each { |_1| @all_temp << _1['Temperature']['Metric']['Value']}
      end  
    end
  end
end
