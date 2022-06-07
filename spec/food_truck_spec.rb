require './lib/food_truck'

RSpec.describe FoodTruck do
  before :each do
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  describe '#initialize' do
    it 'is a FoodTruck' do
      expect(@food_truck).to be_a FoodTruck
    end

    it 'has a name' do
      expect(@food_truck.name).to eq 'Rocky Mountain Pies'
    end
  end
end
