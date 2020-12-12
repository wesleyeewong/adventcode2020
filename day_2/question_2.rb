entries = []

File.open("./question_2_input.txt", "r") do |file|
  file.each_line do |line|
    entry = line.split
    ranges = entry[0].split("-")
    entry[0] = ranges.map(&:to_i)
    entry[1].tr!(":", "")
    entries << entry
  end
end


def solve_part_1(entries)
  valid_count = 0
  entries.each do |entry|
    min = entry[0][0]
    max = entry[0][1]
    target = entry[1]
    password = entry[2]
    alphabet = (('a'..'z').to_a) - [target]
    clean_pass = password.tr(alphabet.join, "")

    if clean_pass.length >= min && clean_pass.length <= max
      valid_count += 1
    end
  end

  p valid_count
end

def solve_part_2(entries)
  valid_count = 0

  entries.each do |entry|
    pos_1 = entry[0][0] - 1 
    pos_2 = entry[0][1] - 1
    target = entry[1]
    password = entry[2]

    if (password[pos_1] == target && password[pos_2] != target) || (password[pos_1] != target && password[pos_2] == target)
      valid_count += 1
    end
  end

  p valid_count
end

solve_part_1(entries)
solve_part_2(entries)
