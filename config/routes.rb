# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'weather/current', to: 'weather#current'
      get 'weather/historical', to: 'weather#historical'
      get 'weather/historical/max', to: 'weather#temp_max'
      get 'weather/historical/min', to: 'weather#temp_min'
      get 'weather/avg', to: 'weather#temp_average'
      get 'weather/by_time/:timestamp', to: 'weather#by_time'
    end
  end
end
