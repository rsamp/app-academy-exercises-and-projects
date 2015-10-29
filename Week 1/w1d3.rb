require 'byebug'

def range(first, last)
  return [] if last < first
  [first] + range(first + 1, last)
end

def sum_rec(arr)
  return 0 if arr.size == 0
  arr.pop + sum_rec(arr)
end

def sum_iter(arr)
  # sum = 0
  # arr.each {|num| sum += num }

  # until arr.size == 0
  #   sum += arr.pop
  # end
  # sum
  arr.inject(&:+)
end

def expo_one(b, e)
  return 1 if e == 0
  b * expo_one(b, e - 1)
end

def expo_two(b, e)
  case e
  when 0
    1
  when 1
    b
  when % 2 == 0
    expo_two(b, e / 2)**2
  else
    b * (expo_two(b, (e - 1) / 2)**2)
  end
end

class Array
  def deep_dup
    arr_copy = []
    each do |el|
      el = el.deep_dup if el.is_a?(Array)
      arr_copy += [el]
    end
    arr_copy
  end
end

def fibonacci(n)
  if n == 0
    []
  elsif n == 1
    [0]
  elsif n == 2
    [0, 1]
  else
    previous_list = fibonacci(n-1)
    previous_list + [previous_list[-2] + previous_list[-1]]
  end
end

def fib_iter(n)
  arr = []
  digit = 1
  count = 1
  until count == n
    if arr.empty?
      arr = [0]
    end
    arr << digit
    digit = arr[-2] + arr[-1]
    count += 1
  end
  arr
end

def bsearch(array, target)
  middle = array.size / 2
  return nil unless array[middle]

  if target == array[middle]
    return middle
  elsif target < array[middle]
    left = array[0...middle]
    return bsearch(left, target)
  elsif target > array[middle]
    right = array[(middle + 1)..-1]
    right_result = bsearch(right, target)
    return middle + right_result + 1 if right_result
  end
end

def make_change(total, coins=[25, 10, 5, 1])
  change = []
  # change_count = 0
  # best_change = []
  return change if total == 0
  # coins.each do |coin|
  #   if total < coin
  #     change << coin
  #   end
  # end
  coin = coins.first
  until total < coin
    change << coin
    total -= coin
  end
  coins.shift unless change.include?(coin)
  change + make_change(total, coins)
  # if change.size > change_count
  #   change_count = change.size
  #   best_change = change
  # end
end

# p make_change(14, [10, 7, 1])
# p make_change(39)

def merge_sort(array)
  return array if array.size <= 1
  left_half = merge_sort(array[0...(array.size / 2)])
  right_half = merge_sort(array[(array.size / 2)..-1])
  # if left_half[0] > right_half[0]
  #   merge(right_half, left_half)
  # else
    merge(left_half, right_half)
  # end
end

def merge(left, right)
  arr = []
  until left.size == 0 && right.size == 0
    if right.empty?
      arr << left.shift
    elsif left.empty?
      arr << right.shift
    elsif left[0] <= right[0]
      arr << left.shift
    elsif right[0] <= left[0]
      arr << right.shift
    end
  end
  arr
end

# p merge_sort([23,2,3434,22,2,6,7,343,1,0,65,2])

def subsets(array)
  return array if array[0] == []
  new_array = []
  p array
  new_array = new_array + [array]
  [array].each do |el|
    new_array << subsets(el)
  end
#   new_array << subsets
#   # return [array] if array.empty?
#   return [[], new_array] if array.size == 1
#   new_array + subsets([array.shift])
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
