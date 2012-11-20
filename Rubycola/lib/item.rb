class Item
  
  attr_accessor :item_name, :price
  
  def initialize(item_name, price, combo)
    @item_name = item_name
    @price = price
    @combo = combo
  end
  
end