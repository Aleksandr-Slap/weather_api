# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'weather/current', to: 'forecasts#current'
      get 'weather/historical', to: 'forecasts#historical'
      get 'weather/historical/max', to: 'forecasts#temp_max'
      get 'weather/historical/min', to: 'forecasts#temp_min'
      get 'weather/avg', to: 'forecasts#temp_average'
      get 'weather/by_time/:timestamp', to: 'forecasts#by_time'
    end
  end
end