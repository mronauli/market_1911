class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.flat_map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    names = @vendors.flat_map do |vendor|
      vendor.inventory.keys.collect do |item|
        item.name
      end
    end
    names.uniq.sort
  end

  def total_inventory
    items = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item|
        if !items[item[0]]
          items[item[0]] = item[1]
        else
          items[item[0]] += item[1]
        end
      end
    end
    items
  end

  def sell(item, quantity)
    sell = {}
    sell[item] = quantity
    return false unless total_inventory.has_key?(item) && total_inventory[item] > sell[item]
    true
  end
end
