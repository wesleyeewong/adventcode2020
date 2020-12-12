require "set"

def solve_part_1()

  preamble_count = 25
  preambles = []

  File.open("./question_9_input.txt", "r") do |file|
    file.each_line.with_index do |line, index|
      number = line.chomp.to_i

      if preambles.size < preamble_count
        preambles << number
        next
      end

      if is_valid(preambles, number)
        preambles << number
        preambles.shift
      else
        p number
        break
      end
    end
  end
end

def is_valid(preambles, number)
  cache = Set.new
  preambles.each do |preamble|
    remaining = (preamble - number).abs

    if cache.include?(remaining)
      return true
    end

    cache << preamble
  end

  return false
end

def solve_part_2()
  target = 20874512
  # target = 127
  min_size = 2
  array = []

  File.open("./question_9_input.txt", "r") do |file|
    file.each_line.with_index do |line, index|
      number = line.chomp.to_i

      array << number
      next if array.size < min_size

      while array.sum > target
        array.shift
      end

      if array.sum == target
        p array
        break
      end
    end
  end

  p array.max + array.min

end

# solve_part_1
solve_part_2
