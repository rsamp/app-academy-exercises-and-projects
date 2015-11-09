class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = 500
    self.each_with_index do |el, i|
      hash_value += el.hash * i**2
    end
    hash_value
  end
end

class String
  def hash
    hash_value = 1234
    chars = self.split("")
    chars.each_with_index do |char, i|
      hash_value += char.ord * i**3
    end
    hash_value
  end
end

# revisit for better hashing between "class" similarities
class Hash
  def hash
    hash_value = 2346
    key_strings = keys.map { |key| key.to_s }
    val_strings = values.map { |val| val.to_s }
    hash_array = (key_strings + val_strings).sort
    hash_value += hash_array.hash
  end
end
