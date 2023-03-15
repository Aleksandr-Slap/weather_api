# frozen_string_literal: true

module Api
  module V1
    class WeathersController < ApplicationController
      
      def current
        current_temp = RequestToWeatherCom.current_temp

        render json: current_temp
      end

      def historical
        hourly_temp = RequestToWeatherCom.historical_temp

        render json: hourly_temp
      end

      def temp_max
        array_with_temperature_day

        render json: @all_temp.max
      end

      def temp_min
        array_with_temperature_day

        render json: @all_temp.min
      end

      def temp_average
        array_with_temperature_day

        average_temp = @all_temp.sum / @all_temp.length

        render json: average_temp.round(1)
      end

      def by_time
        #Method under development
        render json: Time.at(params[:timestamp].to_i)
      end

      private def array_with_temperature_day
        @all_temp = RequestToWeatherCom.temp_max_min
      end  
    end
  end
end

