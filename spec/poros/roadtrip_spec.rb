require 'rails_helper'

RSpec.describe Roadtrip do
  it 'can initialize from roadtrip params' do
    roadtrip_params = {
      route: { hasTollRoad: true,
               hasBridge: true,
               boundingBox: { lr: { lng: -74.004807, lat: 34.052238 }, ul: { lng: -118.244423, lat: 41.596916 } },
               distance: 2794.3513,
               hasTimedRestriction: false,
               hasTunnel: true,
               hasHighway: true,
               computedWaypoints: [],
               routeError: { errorCode: -400, message: '' },
               formattedTime: '40:34:31',
               sessionId: '6153f5fb-027f-6750-02b4-32ca-1265dd3605e3',
               hasAccessRestriction: false,
               realTime: 158_784,
               hasSeasonalClosure: false,
               hasCountryCross: false,
               fuelUsed: 140.85 }
    }

    roadtrip = Roadtrip.new(roadtrip_params, 'New York,NY', 'Los Angeles,CA')

    expect(roadtrip).to be_an_instance_of Roadtrip
    expect(roadtrip.travel_time).to eq('40:34:31')
    expect(roadtrip.travel_hr).to eq(40)
    expect(roadtrip.travel_min).to eq(34)
    expect(roadtrip.origin).to eq('New York,NY')
    expect(roadtrip.destination).to eq('Los Angeles,CA')
  end
end
