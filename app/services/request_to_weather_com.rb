# frozen_string_literal: true

class RequestToWeatherCom

  include HTTParty  

  CURRENT_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212?#{ENV.fetch('API_KEY_WEATHER')}"
  HISTORY_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212/historical/24?#{ENV.fetch('API_KEY_WEATHER')}"

  def self.current_temp
    response = HTTParty.get(CURRENT_WEATHER_URL)
    respone_body = JSON.parse(response.body)
    current_temp = respone_body[0]['Temperature']['Metric']['Value']
  end

  def self.historical_temp
    hourly_temp = {}
    self.response_body.each { hourly_temp[_1['LocalObservationDateTime']] = _1['Temperature']['Metric']['Value'] }

    return hourly_temp
  end  

  def self.temp_max_min
    self.response_body
  end

  def temp_average
    self.response_body.each { all_temp << _1['Temperature']['Metric']['Value']}
    
    return all_temp
  end

  
  private_class_method

  def self.response_body
    response = HTTParty.get(HISTORY_WEATHER_URL)
    respon_body = JSON.parse(response.body)
    all_temp = []
    # byebug
    respon_body.each { all_temp << _1['Temperature']['Metric']['Value'] }

    return all_temp
  end
end