# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'weather/current', to: 'weather#current'
      get 'weather/historical', to: 'weather#historical'
      get 'weather/historical/max', to: 'weather#temp_max'
    end
  end
end
