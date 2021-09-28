class Api::V1::BackgroundSerializer
  include FastJsonapi::ObjectSerializer

  def self.get_background(background, location)
    null = nil
    {
      data: {
        id: null,
        type: 'image',
        attributes: {
          image: {
            description: {
              description: background.description,
              alt_description: background.alt_description,
              location: location
            },
            image_url: background.image_url,
            credit: {
              source: background.source,
              photographer: background.photographer,
              profile: background.profile_url,
              logo: background.logo,
              utm_source: background.utm_source,
              utm_medium: background.utm_medium
            }
          }
        }
      }
    }
  end
end
