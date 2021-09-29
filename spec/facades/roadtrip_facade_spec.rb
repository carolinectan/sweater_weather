require 'rails_helper'

RSpec.describe RoadtripFacade do
  describe 'class methods' do
    describe '.get_roadtrip' do
      context 'happy path' do
        it 'returns a roadtrip object', :vcr do
          origin = 'denver,co'
          destination = 'pueblo,co'

          roadtrip = RoadtripFacade.get_roadtrip(origin, destination)

          expect(roadtrip).to be_a Roadtrip
        end
      end

      context 'sad path' do
        it 'returns an status code', :vcr do
          origin = 'denver,co'
          destination = 'london,uk'

          roadtrip = RoadtripFacade.get_roadtrip(origin, destination)

          expect(roadtrip).to eq(402)
        end
      end
    end
  end
end
