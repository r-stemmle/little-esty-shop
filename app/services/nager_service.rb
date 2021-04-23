require 'faraday'
require 'json'

class NagerService
  attr_accessor :year

  def initialize(year)
    @year = year
  end

  def next_three_holidays
    response = Faraday.get "https://date.nager.at/Api/v1/Get/us/#{year}"
    now = Time.now.strftime("%F")
    json = JSON.parse(response.body, symbolize_names: true)
    select = json.select { |holiday| holiday[:date] > now }.take(3)
  end
end
