class WeatherController < ApplicationController

  include HTTParty

  URL_CURRENT = "http://dataservice.accuweather.com/currentconditions/v1/295212?".freeze
  URL_HISTORY = "http://dataservice.accuweather.com/currentconditions/v1/295212/historical/24?"


  def current
    response = HTTParty.get("#{URL_CURRENT}#{ENV[ 'API_KEY_WEATHER' ]}")
    body = JSON.parse(response.body)
    value = body[0]['Temperature']['Metric']['Value']

    render json: value
  end

  def historical
    response = HTTParty.get("#{URL_HISTORY}#{ENV[ 'API_KEY_WEATHER' ]}")
    body = JSON.parse(response.body)
    values = {}
    body.each do |e|
      time = e['LocalObservationDateTime']
      temp = e['Temperature']['Metric']['Value']
      values[time] = temp
    end
    render json: values
  end

  def temp_max
    
  end  
end
