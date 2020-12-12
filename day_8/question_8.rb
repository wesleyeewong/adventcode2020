def solve_part_1()
  acc = 0
  mapping = {}
  next_index = 0
  executed = []

  File.open("./question_8_input.txt", "r") do |file|
    file.each_line.with_index do |line, index|

      clean = line.chomp
      instruction = clean.split(" ")[0]
      value = clean.split(" ")[1].to_i

      mapping[index] = { instruction: instruction, value: value }
    end
  end

  while !executed.include?(next_index) && mapping.key?(next_index)
    instruction = mapping[next_index][:instruction]
    value = mapping[next_index][:value]

    case instruction
    when "nop"
      executed << next_index
      next_index += 1
    when "acc"
      executed << next_index
      acc += value
      next_index += 1
    when "jmp"
      executed << next_index
      next_index += value
    end

    unless mapping.key?(next_index)
      p "terminated"
    end
  end

  p acc
end

def solve_part_2()
  acc = 0
  mapping = {}
  next_index = 0
  executed = []
  jmp_line = []
  nop_line = []

  File.open("./question_8_input.txt", "r") do |file|
    file.each_line.with_index do |line, index|

      clean = line.chomp
      instruction = clean.split(" ")[0]
      value = clean.split(" ")[1].to_i

      mapping[index] = { instruction: instruction, value: value }
    end
  end

  while !executed.include?(next_index) && mapping.key?(next_index)
    instruction = mapping[next_index][:instruction]
    value = mapping[next_index][:value]

    case instruction
    when "nop"
      executed << next_index
      nop_line << next_index
      next_index += 1
    when "acc"
      executed << next_index
      acc += value
      next_index += 1
    when "jmp"
      jmp_line << next_index
      executed << next_index
      next_index += value
    end
  end

  (nop_line + jmp_line).each do |line|
    cloned = Marshal.load(Marshal.dump(mapping))

    current = cloned[line][:instruction]
    cloned[line][:instruction] = current == "nop" ? "jmp" : "nop"
    executed = []
    next_index = 0
    acc = 0

    while !executed.include?(next_index)
      instruction = cloned[next_index][:instruction]
      value = cloned[next_index][:value]

      case instruction
      when "nop"
        executed << next_index
        next_index += 1
      when "acc"
        executed << next_index
        acc += value
        next_index += 1
      when "jmp"
        executed << next_index
        next_index += value
      end
      unless mapping.key?(next_index)
        p acc
        break
      end
    end
  end
end

# solve_part_1
solve_part_2
