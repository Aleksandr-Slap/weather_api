# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'weather/current', to: 'weathers#current'
      get 'weather/historical', to: 'weathers#historical'
      get 'weather/historical/max', to: 'weathers#temp_max'
      get 'weather/historical/min', to: 'weathers#temp_min'
      get 'weather/avg', to: 'weathers#temp_average'
      get 'weather/by_time/:timestamp', to: 'weathers#by_time'
    end
  end
end
