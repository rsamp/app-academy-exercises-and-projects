class Array
  def remove_dups
    result = []
    self.each { |el| result << el unless result.include?(el) }
    result
  end

  def two_sum
    result = []
    self.each_with_index do |el, idx|
      j = idx+1
      while j < self.length
        result << [idx, j] if el + self[j] == 0
        j+=1
      end
    end
    result
  end

  def my_transpose
    return self unless self.first.is_a?(Array)
    height = self.first.is_a?(Array) ? self[0].length : 1
    result = Array.new(height) {Array.new(self.length)}

    self.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        result[col_idx][row_idx] = el
      end
    end
    result
  end

  def stock_picker
    result = []
    max = 0
    self.each_with_index do |el, idx|
      j = idx+1
      while j < self.length
        if self[j] - el > max
          result = [idx, j]
          max = self[j] - el
        end
        j+=1
      end
    end
    result
  end
end
