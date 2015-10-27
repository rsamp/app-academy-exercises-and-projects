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
    self.each do |el|
      if el.is_a?(Array)
        el.my_flatten.each do |el2|
          result << el2
        end
      else
        result << el
      end
    end
    # self.my_each do |el|
    #   if el.is_a?(Array)
    #     result.concat(el.my_flatten)
    #   else
    #     result << el
    #   end
    # end
    result
  end

  def my_zip(*args)
    result = []
    self.each do |el|
      result << [el]
    end
    args.each do |arg|
      arg.each_with_index do |el, i|
        result[i] << el unless result[i].nil?
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

  def my_rotate(rotation=1)
    return self if rotation == 0
    rotated = []
    self.my_each { |el| rotated << el}
    if rotation > 0
      rotation.times { rotated.push(rotated.shift) }
    elsif rotation < 0
      rotation = 0 - rotation
      rotation.times { rotated.unshift(rotated.pop) }
    end
    rotated
  end

  def my_join(separator="")
    joined = ""
    self.my_each do |el|
      joined << el
      joined << separator
    end
    joined.chomp(separator)
  end

  def my_reverse
    reversed = []
    self.my_each { |el| reversed.unshift(el)}
    reversed
  end

end

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
