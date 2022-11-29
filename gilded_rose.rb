class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if is_sulfuras?(item)
      elsif is_generic?(item)
        if is_quality_more_than?(item, 0)
          if !is_sulfuras?(item)
            decrease_quality(item)
          end
        end
      else
        if is_quality_less_than?(item, 50)
          increase_quality(item)
          if is_backstage?(item)
            if is_sell_less_than?(item, 11)
              if is_quality_less_than?(item, 50)
                increase_quality(item)
              end
            end
            if is_sell_less_than?(item, 6)
              if is_quality_less_than?(item, 50)
                increase_quality(item)
              end
            end
          end
        end
      end
      if !is_sulfuras?(item)
        decrease_sell(item)
      end
      if is_sell_less_than?(item, 0)
        if !is_aged_brie?(item)
          if !is_backstage?(item)
            if is_quality_more_than?(item, 0)
              if !is_sulfuras?(item)
                decrease_quality(item)
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if is_quality_less_than?(item, 50)
            increase_quality(item)
          end
        end
      end
    end
  end

  private

  def is_generic?(item)
    !(is_aged_brie?(item) || is_backstage?(item) || is_sulfuras?(item))
  end

  def decrease_sell(item)
    item.sell_in = item.sell_in - 1
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

  def increase_quality(item)
    item.quality = item.quality + 1
  end

  def decrease_quality(item)
    item.quality = item.quality - 1
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
