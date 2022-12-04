require 'pry'

module Inventory
  class Quality
    attr_reader :amount
    def initialize(amount)
      @amount = amount
    end

    def degrade
      @amount -= 1 if @amount > 0
    end

    def increase
      @amount += 1 if @amount < 50
    end

    def reset
      @amount = 0
    end
  end

  class Generic
    attr_reader :quality, :sell_in

    def initialize(quality, sell_in)
      @quality, @sell_in = Quality.new(quality), sell_in
    end

    def quality
      @quality.amount
    end

    def update
      @quality.degrade
      @sell_in -= 1
      @quality.degrade if @sell_in < 0
    end
  end

  class AgedBrie < Generic

    def update
      @quality.increase
      @sell_in -= 1
      @quality.increase if @sell_in < 0
    end
  end

  class Backstage < Generic
    def update
      @quality.increase
      @quality.increase if @sell_in < 11
      @quality.increase if @sell_in < 6
      @sell_in -= 1
      if @sell_in < 0
        @quality.reset
      end
    end
  end
end

class GildedRose

  class GoodCategory
    def build_for(item)
      if is_generic?(item)
        Inventory::Generic.new(item.quality, item.sell_in)
      elsif is_aged_brie?(item)
        Inventory::AgedBrie.new(item.quality, item.sell_in)
      elsif is_backstage?(item)
        puts item.quality
        Inventory::Backstage.new(item.quality, item.sell_in)
      end
    end

    private

    def is_generic?(item)
      !(is_aged_brie?(item) || is_backstage?(item))
    end

    def is_backstage?(item)
      item.name == "Backstage passes to a TAFKAL80ETC concert"
    end

    def is_aged_brie?(item)
      item.name == "Aged Brie"
    end
  end

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if is_sulfuras?(item)

      item.sell_in -= 1
      good = GoodCategory.new.build_for(item)
      good.update
      item.quality = good.quality
    end
  end

  private

  def is_sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
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
