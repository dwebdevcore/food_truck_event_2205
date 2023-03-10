require 'date'

class Event
  attr_reader :name, :food_trucks, :date

  def initialize(name)
    @name = name
    @food_trucks = []

    #Probably a much better way to format this but this is what you all get :)
    unformatted_date = Date.today.to_s
    day = unformatted_date[-2..-1]
    month = unformatted_date[-5..-4]
    year = unformatted_date[0..-7]
    @date = "#{day}/#{month}/#{year}"
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

  def sorted_item_list
    items = []
    @food_trucks.each do |truck|
      truck.inventory.each do |item, _|
        items << item.name
      end
    end

    #adding to clean up output / test
    if items.count > 0
      items.sort.uniq
    else
      items
    end
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

  def overstocked_items
    items_hash = total_inventory
    overstocked = []
    items_hash.keys.each do |item|
      if (items_hash[item][:quantity] > 50) && (items_hash[item][:food_trucks].count > 1)
        overstocked << item
      end
    end
    overstocked

    # was trying to see if I could get this to work but wasn't working. could have been my tests were still messed up from earlier when I tried it.
    
    # items_hash.keys.find_all do |item|
    #   (items_hash[item][:quantity] > 50) && (items_hash[item][:food_trucks].count > 1)
    # end
  end
end
