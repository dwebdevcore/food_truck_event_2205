require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
  before :each do
    @event = Event.new("South Pearl Street Farmers Market")
  end

  describe '#initialize' do
    it 'is an Event' do
      expect(@event).to be_a Event
    end

    it 'has a name' do
      expect(@event.name).to eq 'South Pearl Street Farmers Market'
    end

    it 'has an empty array of FoodTrucks' do
      expect(@event.food_trucks).to eq []
    end
  end
end
