require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    key_hash = key.hash
    mod = key_hash % num_buckets
    @store[mod]
  end

  def num_buckets
    @store.length
  end

  def resize!
    flattened_store = @store.flatten
    @store = Array.new(@store.size * 2) { Array.new }
    @count = 0

    flattened_store.each do |el|
      insert(el)
    end
  end
end
