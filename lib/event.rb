class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    truck_names = @food_trucks.map { |truck| truck.name }
  end

  def food_trucks_that_sell(item)
    trucks = []
    trucks = @food_trucks.find_all do |truck|
      truck.check_stock(item) != 0
    end
  end

  # def overstocked_items
  #
  # end

  def sorted_item_list
    items = []
    @food_trucks.each do |truck|
      truck.inventory.each do |item, _|
        items << item.name
      end
    end
    items.sort.uniq!
  end

  def total_inventory
    items_hash = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        if items_hash.keys.include?(item)
          items_hash[item][:quantity] += quantity
        else
          items_hash[item]= {
            quantity: quantity,
            food_trucks: food_trucks_that_sell(item)
          }
        end
      end
    end
    items_hash
  end
end
