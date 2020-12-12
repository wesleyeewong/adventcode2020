entries = []

File.open("./question_4_input.txt", "r") do |file|
  index = 0

  file.each_line.with_index do |line, line_index|
    if line == "\n"
      index +=1
      next
    end

    clean_line = line.chomp
    key_value_pairs = clean_line.split(" ")

    entry = entries[index]

    if entries.count == index
      entry = Array.new
      entries << entry
    end

    key_value_pairs.each do |pair|
      entry << pair.split(":")[0]
    end
  end
end

def solve_part_1(entries)
  complete = %w[byr iyr eyr hgt hcl ecl pid]
  count = 0
  entries.each do |entry|
    if complete.sort == (entry - ["cid"]).sort
      count += 1
    end
  end

  p count
end

def solve_part_2()
  entries = []

  File.open("./question_4_input_example.txt", "r") do |file|
    index = 0
    count = 0

    file.each_line.with_index do |line, line_index|
      entry = entries[index]

      if line == "\n"
        index += 1
        count += evaluate_entry(entry)
        next
      end

      clean_line = line.chomp
      key_value_pairs = clean_line.split(" ")


      if entries.count == index
        entry = Array.new
        entries << entry
      end

      key_value_pairs.each do |pair|
        entry << pair
      end
    end

    count += evaluate_entry(entries[-1])
    p count
  end
end

def evaluate_entry(entry)
  keys = Array.new
  complete = %w[byr iyr eyr hgt hcl ecl pid]
  valid = true

  entry.each do |pair|
    key = pair.split(":")[0]
    keys << key
    value = pair.split(":")[1]

    case key
    when "byr"
      if value.size != 4 || (value.to_i < 1920 || value.to_i > 2002)
        p "byr invalid"
        valid = false

      end
    when "iyr"
      if value.size != 4 || (value.to_i < 2010 || value.to_i > 2020)
        p "iyr invalid"
        valid = false

      end
    when "eyr"
      if value.size != 4 || (value.to_i < 2020 || value.to_i > 2030)
        p "eyr invalid"
        valid = false

      end
    when "hgt"
      if value.end_with? "cm"
        height = value.tr("cm", "")
        if height.size != 3 || (height.to_i < 150 || height.to_i > 193)
          p "cm invalid"
          valid = false

        end
      elsif value.end_with? "in"
        height = value.tr("in", "")
        if height.size != 2 || (height.to_i < 59 || height.to_i > 76)
          p "in invalid"
          valid = false

        end
      else
        p "hgt invalid"
        valid = false

      end
    when "hcl"
      if value.start_with? "#"
        if value.tr("#", "").size != 6 || value.count("0-9a-f") != 6
          valid = false
        end
      else
        valid = false
      end
    when "ecl"
      color = %w[amb blu brn gry grn hzl oth]
      if value.size != 3
        valid = false
      end
      unless color.include?(value)
        valid = false
      end
    when "pid"
      if value.size != 9 || value.count("0-9") != 9
        valid = false
      end
    end
  end
  return 1 if valid && complete.sort == (keys - ["cid"]).sort
  0
end

solve_part_1(entries)
solve_part_2()
