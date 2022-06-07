class Item
  attr_reader :name, :price


  # NEED TO FIX PRICE TO OUTPUT 2 DECIMAL PLACES ???
  def initialize(attributes)
    @name = attributes[:name]
    @price = attributes[:price].gsub('$', '').to_f
  end

end
