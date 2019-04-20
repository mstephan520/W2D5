require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num)
    self.store[num] = true
  end

  def remove(num)
    self.store[num] = false 
  end

  def include?(num)
    self.store[num] == true 
  end

  private

  def is_valid?(num)
    num > self.store.length || num < 0
  end

  def validate!(num)
  end
  protected 
  attr_accessor :store
end


class IntSet

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self.store[num % 20] << num
  end

  def remove(num)
    self.store[num % 20].delete(num)
  end

  def include?(num)
    self.store[num % 20].include?(num)
  end

  protected
  attr_accessor :store

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    unless include?(num)
      self.store[num % num_buckets] << num
      self.count += 1
    end
  end

  def remove(num)
    if include?(num) 
      self.store[num % num_buckets].delete(num)
      self.count -= 1
    end
  end

  def include?(num)
    self.store[num % num_buckets].include?(num)
  end

  protected
    attr_accessor :store

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    # self.store
    resized = Array.new(num_buckets * 2) { Array.new }
    
    self.store.each do |bucket|
      bucket.each do |ele|
        resized[ele % resized.length] << ele unless ele == 0
        # resized[0] << ele if ele == 0
      end
    end

    self.store = resized
  end

end
