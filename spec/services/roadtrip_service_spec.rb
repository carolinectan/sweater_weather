require 'rails_helper'

RSpec.describe RoadtripService do
  describe 'class methods' do
    describe '.get_roadtrip' do
      it 'returns roadtrip info based on origin and destination', :vcr do
        roadtrip = RoadtripService.get_roadtrip('denver,co', 'pueblo, co')

        expect(roadtrip).to be_a Hash
        expect(roadtrip).to have_key(:route)
        expect(roadtrip[:route]).to be_a Hash
        expect(roadtrip[:route]).to have_key(:hasTollRoad)
        expect(roadtrip[:route][:hasTollRoad]).to be_in([true, false])
        expect(roadtrip[:route]).to have_key(:hasBridge)
        expect(roadtrip[:route][:hasBridge]).to be_in([true, false])
        expect(roadtrip[:route]).to have_key(:boundingBox)
        expect(roadtrip[:route][:boundingBox]).to be_a Hash
        expect(roadtrip[:route]).to have_key(:distance)
        expect(roadtrip[:route][:distance]).to be_a Numeric
        expect(roadtrip[:route]).to have_key(:hasTunnel)
        expect(roadtrip[:route][:hasTunnel]).to be_in([true, false])
        expect(roadtrip[:route]).to have_key(:hasHighway)
        expect(roadtrip[:route][:hasHighway]).to be_in([true, false])
        expect(roadtrip[:route]).to have_key(:computedWaypoints)
        expect(roadtrip[:route][:computedWaypoints]).to be_an Array
        expect(roadtrip[:route]).to have_key(:routeError)
        expect(roadtrip[:route][:routeError]).to be_a Hash
        expect(roadtrip[:route]).to have_key(:formattedTime)
        expect(roadtrip[:route][:formattedTime]).to be_a String
        expect(roadtrip[:route]).to have_key(:sessionId)
        expect(roadtrip[:route][:sessionId]).to be_a String
        expect(roadtrip[:route]).to have_key(:realTime)
        expect(roadtrip[:route][:realTime]).to be_a Numeric
        expect(roadtrip[:route]).to have_key(:hasSeasonalClosure)
        expect(roadtrip[:route][:hasSeasonalClosure]).to be_in([true, false])
        expect(roadtrip[:route]).to have_key(:fuelUsed)
        expect(roadtrip[:route][:fuelUsed]).to be_a Numeric
        expect(roadtrip[:route]).to have_key(:legs)
        expect(roadtrip[:route][:legs]).to be_an Array
      end
    end

    describe '.get_conn' do
      it 'returns a Faraday object for a roadtrip', :vcr do
        conn = RoadtripService.conn

        expect(conn).to be_a Faraday::Connection
      end
    end
  end
end
