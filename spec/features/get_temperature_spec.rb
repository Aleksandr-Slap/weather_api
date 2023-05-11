require 'rails_helper'

RSpec.describe 'Weather Api', type: :request do

  let!(:forecast) { create(:forecast)}

  describe 'GET api/v1/weather/current' do 
    it 'get the current temperature' do
      get '/api/v1/weather/current'

      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'GET api/v1/weather/historical/max' do 
    it 'get the max temperature' do
      get '/api/v1/weather/historical/max'

      expect(JSON.parse(response.body)).to eq({ "max_temp" => forecast.max })
    end
  end

  describe 'GET api/v1/weather/historical/min' do 
    it 'get the min temperature' do
      get '/api/v1/weather/historical/min'

      expect(JSON.parse(response.body)).to eq({ "min_temp" => forecast.min })
    end
  end

  describe 'GET api/v1/weather/avg' do 
    it 'get the average temperature' do
      get '/api/v1/weather/avg'

      expect(JSON.parse(response.body)).to eq("average_temp" => forecast.avg)
    end
  end

  describe 'GET api/v1/weather/historical' do 
    it 'get the history temperature' do
      get '/api/v1/weather/historical'

      expect(JSON.parse(response.body)).to eq("historical_temp" => forecast.history)
    end
  end
  
  describe 'GET api/v1/weather/by_time/:timestamp' do
    context 'get the by time temperature' do
      it 'valid timestamp' do
        get '/api/v1/weather/by_time/1682071200'

        expect(JSON.parse(response.body)).to eq({"by_time_temp"=>"12.9"})
        # binding.pry
      end
    end

    it 'invalid timestamp' do
      expect{ get '/api/v1/weather/by_time/1582071200'}.to raise_error(ActionController::RoutingError)
    end
  end
end