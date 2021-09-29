require 'rails_helper'

RSpec.describe BackgroundFacade do
  describe 'class methods' do
    describe '.get_background' do
      it 'returns a background object', :vcr do
        location = 'denver,co'

        background = BackgroundFacade.get_background(location)

        expect(background).to be_a Background
      end
    end
  end
end
