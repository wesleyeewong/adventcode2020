def solve_part_1()
  File.open("./question_6_input.txt", "r") do |file|
    total = 0
    yes = []
    file.each_line do |line|
      if line == "\n"
        total += yes.uniq.count
        yes = []
      end

      yes += line.chomp.split("")
    end

    total += yes.uniq.count
    p total
  end
end

def solve_part_2()
  File.open("./question_6_input.txt", "r") do |file|
    total = 0
    yes = []
    first_input = true

    file.each_line do |line|
      if line == "\n"
        total += yes.uniq.count
        yes = []
        first_input = true
      else
        if yes.size == 0 && first_input
          yes += line.chomp.split("")
          first_input = false
        else
          yes = yes & line.chomp.split("")
        end
      end
    end

    total += yes.uniq.count
    p total
  end
end

solve_part_1
solve_part_2
