Rails.application.routes.draw do
  get 'weather/current', to: 'weather#current'
  get 'weather/historical', to: 'weather#historical'
  get 'weather/historical/max', to: 'weather#temp_max'
end
