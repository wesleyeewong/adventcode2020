def solve_part_1()

  jolts = [0]

  File.open("./question_10_input.txt", "r") do |file|
    file.each_line do |line|
      number = line.chomp.to_i

      insert_at = -1
      jolts.each_with_index do |jolt, index|
        if number < jolt
          insert_at = index
          break
        end
      end

      jolts.insert(insert_at, number)
    end
  end

  jolts << (jolts[-1] + 3)

  diff_hash = Hash.new(0)

  index = 1
  prev = 0

  while index < jolts.size
    diff = jolts[index] - jolts[prev]
    diff_hash[diff] += 1

    index += 1
    prev += 1

  end

  p diff_hash
  p diff_hash[1] * diff_hash[3]
end


def solve_part_2()
  jolts = [0]

  File.open("./question_10_input.txt", "r") do |file|
    file.each_line.with_index do |line, index|
      number = line.chomp.to_i

      insert_at = -1
      jolts.each_with_index do |jolt, index|
        if number < jolt
          insert_at = index
          break
        end
      end

      jolts.insert(insert_at, number)
    end
  end

  consecutives_hash = Hash.new(0)

  size = 0
  index = 1
  prev = 0

  while index < jolts.size
    if (jolts[index] - jolts[prev] == 1)
      if size == 0
        size += 1
      end
      size += 1 
    elsif size > 2
      consecutives_hash[size] += 1
      size = 0
    else
      size = 0
    end

    index += 1
    prev += 1
  end

  if size > 2
    consecutives_hash[size] += 1
  end

  p consecutives_hash

  fives = consecutives_hash[5]
  fours = consecutives_hash[4]
  threes = consecutives_hash[3]

  p (7 ** fives) * (4 ** fours) * (2 ** threes)

end

solve_part_1
solve_part_2
