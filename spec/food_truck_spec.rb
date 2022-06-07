require './lib/food_truck'
require './lib/item'

RSpec.describe FoodTruck do
  before :each do
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new(
      {
        name: 'Peach Pie (Slice)',
        price: "$3.75"
        }
      )
    @item2 = Item.new(
      {
        name: 'Apple Pie (Slice)',
        price: '$2.50'
        }
      )
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

    it 'returns quantity if there is stock of an item' do
      expect(@food_truck.check_stock(@item1)).to eq 0
      @food_truck.stock(@item1, 30)
      expect(@food_truck.check_stock(@item1)).to eq 30
    end
  end

  describe '#stock' do
    it 'can add stock to the inventory hash' do
      expect(@food_truck.check_stock(@item1)).to eq 0
      @food_truck.stock(@item1, 30)
      expect(@food_truck.inventory).to eq ({@item1 => 30})
    end
  end

  describe '#potential_revenue' do
    it 'returns potential revenue for a truck' do
      expect(@food_truck.potential_revenue).to eq 0.0
      @food_truck.stock(@item1, 30)
      expect(@food_truck.potential_revenue).to eq 112.50
      @food_truck.stock(@item2, 30)
      expect(@food_truck.potential_revenue).to eq 187.50
    end
  end
end
