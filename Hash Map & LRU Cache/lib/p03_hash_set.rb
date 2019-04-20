class HashSet

  attr_accessor :store, :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if self.count == num_buckets
    unless include?(key)
      store[key.hash % num_buckets] << key 
      self.count += 1
    end
  end

  def include?(key)
    store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    if include?(key)
      store[key.hash % num_buckets].delete(key)
      self.count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
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
