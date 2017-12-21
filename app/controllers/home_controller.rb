class HomeController < ApplicationController
  def index
    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!

    if params[:city] != nil
      params[:city].gsub!(" ", "_")
    end

    if params[:state] != "" && params[:city] != "" && params[:state] != nil && params[:city] != nil
      response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
    else
      response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Charlotte.json")
    end

    if response.dig('location', 'city').nil?
      response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Charlotte.json")
    end

    @location_city = response['location']['city']
    @location_state = response['location']['state']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather']
    @forecast_link = response['current_observation']['forecast_url']
    @feels_like_f = response['current_observation']['feelslike_f']
    @feels_like_c = response['current_observation']['feelslike_c']
    
  end

  def test
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Charlotte.json")

    @location_city = response['location']['city']
    @location_state = response['location']['state']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather']
    @forecast_link = response['current_observation']['forecast_url']
    @feels_like_f = response['current_observation']['feelslike_f']
    @feels_like_c = response['current_observation']['feelslike_c']
  end
end

# another method of formatting response variables
# def test
#   response = HTTParty.get('http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/condiitons/q.NC/Charlotte.json')
#
#   @results = {}
#
#   @results[:location]
#   @results[:temp_f] = response['current_observation']['temp_f']
#   @results[:temp_c] = response['current_observation']['temp_c']
#   @results[:weather_icon] = response['current_observation']['icon_url']
#   @results[:weather_words] = response['current_observation']['weather']
#   @results[:forecast_link] = response['current_observation']['forecast_url']
#   @results[:feels_like_f] = response['current_observation']['feelslike_f']
#   @results[:feels_like_c] = response['current_observation']['feelslike_c']
# end
