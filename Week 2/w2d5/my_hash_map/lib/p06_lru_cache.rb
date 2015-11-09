require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @store.include?(key)
      update_link!(@map.get(key))
      @store.get(key)
    else
      calc!(key)
      @store.get(key)
      # calculated_val = calc!(key)
      # insert_uncached_key(key, calculated_val)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    eject! if @max == count
    insert_uncached_key(key, val)
  end

  def insert_uncached_key(key, value)
    link = @store.insert(key, value)
    @map.set(key, link)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    if link == @store.head
      @store.head = link.next
      link.next.prev = nil
    elsif link == @store.tail
      return
    else
      # link.prev
      # @store.remove(link.key)
      link.prev.next = link.next
      link.next.prev = link.prev
    # else
    #   "hello"
    end
    # @store.remove(link.key)
    @store.insert(link.key, link.val)
    link = nil
  end

  def eject!
    least_recently_used = @store.head
    @store.remove(least_recently_used)
    @map.delete(least_recently_used)
  end
end
