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

    it 'has an empty hash of inventory' do
      expect(@food_truck.inventory).to eq ({})
    end
  end

  describe '#check_stock' do
    it 'returns 0 if there is no stock of an item' do
      expect(@food_truck.check_stock(@item1)).to eq 0
    end
  end
end
