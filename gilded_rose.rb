require 'pry'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if is_sulfuras?(item)
      elsif is_generic?(item)
        handle_generic(item)
      elsif is_aged_brie?(item)
        handle_aged_brie(item)
      elsif is_backstage?(item)
        handle_backstage(item)
      end
    end
  end

  private

  def handle_backstage(item)
    if is_quality_less_than?(item, 50)
      item.quality += 1
      item.sell_in -= 1
      if is_sell_less_than?(item, 11)
        if is_quality_less_than?(item, 50)
          item.quality += 1
        end
      end
      if is_sell_less_than?(item, 6)
        if is_quality_less_than?(item, 50)
          item.quality += 1
        end
      end
    end
    if is_sell_less_than?(item, 0)
      item.quality = item.quality - item.quality
    end
  end

  def handle_aged_brie(item)
    if is_quality_less_than?(item, 50)
      item.quality += 1
      item.sell_in -= 1
    end
    if is_sell_less_than?(item, 0)
      if is_quality_less_than?(item, 50)
        item.quality += 1
      end
    end
  end

  def handle_generic(item)
    if is_quality_more_than?(item, 0)
      item.quality -= 1
      item.sell_in -= 1
    end
    if is_sell_less_than?(item, 0)
      if is_quality_more_than?(item, 0)
        item.quality -= 1
      end
    end
  end

  def is_generic?(item)
    !(is_aged_brie?(item) || is_backstage?(item) || is_sulfuras?(item))
  end

  def is_sell_less_than?(item, value)
    item.sell_in < value
  end

  def is_sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def is_quality_less_than?(item, value)
    item.quality < value
  end

  def is_quality_more_than?(item, value)
    item.quality > value
  end

  def is_backstage?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def is_aged_brie?(item)
    item.name == "Aged Brie"
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
