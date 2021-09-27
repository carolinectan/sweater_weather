class Background
  attr_reader :description,
              :alt_description,
              :image_url,
              :profile_url,
              :photographer,
              :utm_source,
              :utm_medium,
              :source,
              :logo

  def initialize(info)
    @description = info[:description]
    @alt_description = info[:alt_description]
    @image_url = info[:urls][:regular]
    @profile_url = info[:user][:links][:html]
    @photographer = info[:user][:name]
    @utm_source = 'Sweater Weather'
    @utm_medium = 'referral'
    @source = 'upsplash.com'
    @logo = 'https://unsplash.com/blog/content/images/max/2560/1-VnKoValwGK3-d1bZhD6sVA.jpeg'
  end
end
