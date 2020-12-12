entries = []

File.open("./question_3_input.txt", "r") do |file|
  file.each_line do |line|
    entry = line.split("") - ["\n"]
    entries << entry
  end
end





def solve_part_1(entries)
  trees = 0

  entries.each_with_index do |entry, index|
    next if index == 0

    final_position = index * 3
    encounter = entry[final_position % entry.count]
    if encounter == "#"
      trees += 1
    end
  end

    p trees
end

def solve_part_2(entries)
  trees_count = [] 
  slopes = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2]
  ]

  slopes.each do |slope|
    right = slope[0]
    down = slope[1]
    trees = 0

    entries.each_with_index do |entry, index|
      next if index == 0
      next unless (index % down  == 0)
      final_position = index * right
      encounter = entry[final_position % entry.count]
      if encounter == "#"
        trees += 1
      end
    end

    trees_count << trees
  end

  p trees_count
  p trees_count.inject(:*)
end

solve_part_1(entries)
solve_part_2(entries)
