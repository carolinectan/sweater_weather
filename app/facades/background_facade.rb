class BackgroundFacade
  def self.get_background(location)
    json = BackgroundService.get_background(location)

    Background.new(json[:results].first)
  end
end
