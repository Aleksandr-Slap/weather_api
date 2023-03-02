Rails.application.routes.draw do
  namespace 'weather' do
    namespace 'historical' do
      get '/', to: 'weather#historical'
      get '/max', to: 'weather#temp_max'
    end
    get '/current', to: 'weather#current'
  end    
end
