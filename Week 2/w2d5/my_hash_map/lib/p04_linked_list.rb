class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @prev = key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
    # curr_link = @head
    # while curr_link.next
    #   curr_link = curr_link.next
    # end
    # curr_link
  end

  def empty?
    @head.key.nil?
  end

  def get(key)
    curr_link = @head
    while curr_link
      return curr_link.val if curr_link.key == key
      curr_link = curr_link.next
    end
    nil
  end

  def include?(key)
    curr_link = @head
    while curr_link
      return true if curr_link.key == key
      curr_link = curr_link.next
    end
    false
  end

  def insert(key, val)
    if first.key == nil
      @head.key, @head.val = key, val
      @head
    else
      new_link = Link.new(key, val, nil, last)
      last.next = new_link
      @tail = new_link
    end
  end

  def remove(key)
    curr_link = @head
    if curr_link.key == key
      @head = curr_link.next
      curr_link = nil
      return true
    end

    while curr_link.next
      if curr_link.next.key == key
        curr_link.prev.next = curr_link.next
        curr_link.next.prev = curr_link.prev
        curr_link = nil
        return
        # next_link = curr_link.next
        # curr_link.next = next_link.next
        # next_link = nil
      end
      curr_link = curr_link.next
    end
    nil
  end

  def each(&prc)
    curr_link = @head
    while curr_link
      prc.call(curr_link)
      curr_link = curr_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
