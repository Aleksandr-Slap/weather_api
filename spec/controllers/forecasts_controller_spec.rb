require 'rails_helper'

RSpec.describe Api::V1::ForecastsController, type: :controller do

  let!(:forecast) { create(:forecast) }

  describe 'GET #current' do
    it 'returns temperature' do
      allow(HTTParty).to receive(:get).and_return(double(body: '[{"Temperature":{"Metric":{"Value":25}}}]'))
      get :current
      expect(response.parsed_body).to eq({"current_temp" => 25})
    end
  end
  
  describe 'GET #temp_max' do
    it 'returns maximum temperature' do

      get :temp_max
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq({ "max_temp" => forecast.max })
    end
  end

  describe 'GET #temp_min' do
    it 'returns minimum temperature' do

      get :temp_min
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq({ "min_temp" => forecast.min })
    end
  end

  describe 'GET #temp_avg' do
    it 'returns average temperature' do

      get :temp_average
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq({ "average_temp" => forecast.avg })
    end
  end

  describe 'GET #temp_historical' do
    it 'returns historical temperature' do

      get :historical
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq({ "historical_temp" => forecast.history })
    end
  end

  describe 'GET #by_time' do
    context 'valid timestamp' do
      it 'return tempepature' do

        get :by_time, params: { timestamp: 1682071200 }
        expect(response.parsed_body).to eq({ "by_time_temp" => forecast.history[0]['temp'] })
      end
    end
    
    context 'invalid timestamp' do   
      it 'return 404' do

        expect{ get :by_time, params: { timestamp: 1582071200 } }.to raise_error(ActionController::RoutingError)
      end  
    end
  end  
end