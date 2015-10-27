require 'byebug'

class Array

  def my_each(&blk)
    i = 0
    while i < self.length
      blk.call(self[i])
      i+=1
    end
    return self
  end

  def my_select(&blk)
    result = []
    self.my_each do |el|
      if blk.call(el) == true
        result << el
      end
    end
    result
  end

  def my_reject(&blk)
    result = []
    self.my_each do |el|
      if blk.call(el) == false
        result << el
      end
    end
    result
  end

  def my_any?(&blk)
    self.my_each do |el|
      if blk.call(el) == true
        return true
      end
    end
    false

  end

  def my_all?(&blk)
    self.my_each do |el|
      if blk.call(el) == false
        return false
      end
    end
    true
  end

  def my_flatten
    result = []

    # i = 0
    # while i < self.length
    #   if self[i].is_a?(Array)
    #     j = 0
    #     el = self[i].my_flatten
    #     while j < self[i].length
    #       result << el[j]
    #       j += 1
    #     end
    #   else
    #     result << self[i]
    #   end
    #     i += 1
    # end
    self.each do |el|
      if el.is_a?(Array)
        el.my_flatten.each do |el2|
          result << el2
        end
      else
        result << el
      end
    end
    result
  end

  def my_zip(*args)
    result = []
    self.each do |el|
      result << [el]
    end
    args.each_with_index do |arg, i|
      arg.each_with_index do |el, j|
        result[j] << el unless result[j].nil?
      end
      # while result[i].length < self.length
      #   result[i] << nil
      # end
    end
    result.each do |arr|
      while arr.length < self.length
        arr << nil
      end
    end
    result
  end

end

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
#
c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
