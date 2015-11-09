require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    delete(key) if include?(key)
    @store[bucket(key)].insert(key, val)
    @count += 1
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |list|
      list.each do |link|
        next if link.key.nil?
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    store_linked_list = LinkedList.new
    self.each do |key, val|
      store_linked_list.insert(key, val)
    end

    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    store_linked_list.each do |link|
      set(link.key, link.val)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key_hash = key.hash
    key_hash % num_buckets
  end
end
