require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
  before :each do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
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
    @item3 = Item.new(
      {
        name: "Peach-Raspberry Nice Cream",
        price: "$5.30"
        }
      )
    @item4 = Item.new(
      {
        name: "Banana Nice Cream",
        price: "$4.25"
        }
      )
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

  describe '#add_food_truck' do
    it 'can add a FoodTruck to the array' do
      @event.add_food_truck(@food_truck1)
      expect(@event.food_trucks).to eq [@food_truck1]
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks).to eq [@food_truck1, @food_truck2, @food_truck3]
    end
  end

  describe '#food_truck_names' do
    it 'can return an array of strings of truck names' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expected_output = [
        @food_truck1.name,
        @food_truck2.name,
        @food_truck3.name
      ]
      expect(@event.food_truck_names).to eq expected_output
    end
  end

  describe '#food_trucks_that_sell' do
    it 'returns an empty array if no FoodTrucks sell an item' do
      expect(@event.food_trucks_that_sell('pickles')).to eq []
    end

    it 'returns an array of FoodTrucks that sell an item (it is in inventory)' do
      @food_truck1.stock(@item1, 35)
      @food_truck3.stock(@item1, 65)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks_that_sell(@item1)).to eq [@food_truck1, @food_truck3]
    end
  end

  describe '#overstocked_items' do
    it 'returns an empty array if no items are overstocked' do
      expect(@event.overstocked_items).to eq []
    end

    it 'returns an array of items sold by >1 food truck where total quantity >50' do
      @food_truck1.stock(@item1, 35)
      @food_truck3.stock(@item1, 65)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck3)
      expect(@event.overstocked_items).to eq [@item1]
    end
  end

  describe '#sorted_item_list' do
    # Add this test later if time permits
    # it 'returns an empty array if there are no items' do
    #   expect(@event.sorted_item_list).to eq []
    # end

    it 'returns an array of items sold sorted alphabetically' do
      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expected_output =
      [
        "Apple Pie (Slice)",
        "Banana Nice Cream",
        "Peach Pie (Slice)",
        "Peach-Raspberry Nice Cream"
      ]
      expect(@event.sorted_item_list).to eq expected_output
    end
  end

  # describe '#total_inventory' do
  #   it 'returns a hash where items are keys, and values are a hash of quantity and food trucks selling the item' do
  #     @food_truck1.stock(@item1, 35)
  #     @food_truck1.stock(@item2, 7)
  #     @food_truck2.stock(@item4, 50)
  #     @food_truck2.stock(@item3, 25)
  #     @food_truck3.stock(@item1, 65)
  #     @food_truck3.stock(@item3, 10)
  #     @event.add_food_truck(@food_truck1)
  #     @event.add_food_truck(@food_truck2)
  #     @event.add_food_truck(@food_truck3)
  #     expected_output = {
  #       @item1 => {
  #         quantity: 100,
  #         food_trucks: [@food_truck1, @food_truck3]
  #       },
  #       @item2 => {
  #         quantity: 7,
  #         food_trucks: [@food_truck1]
  #       },
  #       @item4 => {
  #         quantity: 50,
  #         food_trucks: [@food_truck2]
  #       },
  #       @item3 => {
  #         quantity: 35,
  #         food_truck: [@food_truck2, @food_truck3]
  #       }
  #     }
  #     expect(@event.total_inventory).to eq expected_output
  #   end
  # end
end
