class Api::V1::ForecastSerializer
  include FastJsonapi::ObjectSerializer

  def self.get_weather(forecast)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            datetime: forecast.current.datetime,
            sunrise: forecast.current.sunrise,
            sunset: forecast.current.sunset,
            temperature: forecast.current.temperature,
            feels_like: forecast.current.feels_like,
            humidity: forecast.current.humidity,
            uvi: forecast.current.uvi,
            visibility: forecast.current.visibility,
            conditions: forecast.current.conditions,
            icon: forecast.current.icon
          },
          daily_weather: forecast.daily.map do |daily|
            {
              date: daily.date,
              sunrise: daily.sunrise,
              sunset: daily.sunset,
              max_temp: daily.max_temp,
              min_temp: daily.min_temp,
              conditions: daily.conditions,
              icon: daily.icon
            }
          end,
          hourly_weather: forecast.hourly.map do |hourly|
            {
              time: hourly.time,
              temperature: hourly.temperature,
              conditions: hourly.conditions,
              icon: hourly.icon
            }
          end
        }
      }
    }
  end
end
