Rails.application.routes.draw do
  namespace 'weather' do
    get 'current', to: 'weather#current'
    get 'historical', to: 'weather#historical'
    get 'historical/max', to: 'weather#temp_max'
  end
end
