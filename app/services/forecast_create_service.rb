# frozen_string_literal: true

class ForecastCreateService

  include HTTParty  

  # CURRENT_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212?#{ENV.fetch('API_KEY_WEATHER')}"
  HISTORY_WEATHER_URL = "http://dataservice.accuweather.com/currentconditions/v1/295212/historical/24?#{ENV.fetch('API_KEY_WEATHER')}"

  def call
    response_body
    get_attributes
    avg_temp
    histori_temp
    Forecast.create!(max: @all_temp.max , min: @all_temp.min, avg: @avg.round(1), history: [@hourly_temp] )
  end

  private

  def response_body
    response = HTTParty.get(HISTORY_WEATHER_URL)
    @respon_body = JSON.parse(response.body)

    # return @respon_body
  end

  def get_attributes
    @all_temp = []
    @respon_body.each { @all_temp << _1['Temperature']['Metric']['Value'] }

    return @all_temp
  end 

  def histori_temp
    @hourly_temp = {}
    @respon_body.each { @hourly_temp[_1['LocalObservationDateTime']] = _1['Temperature']['Metric']['Value'] }
    # byebug
    return @hourly_temp
  end

  def avg_temp
    @avg = @all_temp.sum / @all_temp.size
  end  



  # def temp_average
  #   @all_temp = @response_body.each { all_temp << _1['Temperature']['Metric']['Value']}
    
  #   return @all_temp
  # end

  # def self.current_temp
  #   response = HTTParty.get(CURRENT_WEATHER_URL)
  #   respone_body = JSON.parse(response.body)
  #   current_temp = respone_body[0]['Temperature']['Metric']['Value']
  # end


  # def self.temp_max_min
  #   self.response_body
  # end


  
  # private_class_method

  # def self.response_body
  #   response = HTTParty.get(HISTORY_WEATHER_URL)
  #   respon_body = JSON.parse(response.body)
  #   all_temp = []
  #   # byebug
  #   respon_body.each { all_temp << _1['Temperature']['Metric']['Value'] }

  #   return all_temp
  # end
end