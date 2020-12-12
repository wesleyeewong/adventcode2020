def solve_part_1()
  target = "shiny gold"
  reverse_map = Hash.new()
  check_again = []
  answer = []
  parent_bag_pattern = /(^([\w\s\w]+?(?=\sbags\s)).*contain\s)/
  content_rule_pattern = /([0-9]+\s[a-z]+\s[a-z]+)(?=\s[bag|bags])/


  File.open("./question_7_input.txt", "r") do |file|
    file.each_line do |line|
      rule = line.chomp
      parent_color = rule.match(parent_bag_pattern).captures[1]
      content_rule = rule.sub(parent_bag_pattern, "")

      if parent_color != target && !answer.include?(parent_color)
        content_matches = content_rule.scan(content_rule_pattern).each do |match|
          color = match[0].split(" ").last(2).join(" ")
          if color == target || answer.include?(color)
            answer << parent_color

            if reverse_map.key?(parent_color)
              add_answer(reverse_map, parent_color, answer)
            end
            answer&.flatten!&.uniq!

            break
          elsif color != target
              if reverse_map.key?(color)
              reverse_map[color] = (reverse_map[color] << parent_color).uniq
            else
              reverse_map[color] = [parent_color]
            end
          end
        end
      end
    end
  end

  p answer.flatten.uniq.count

end

def add_answer(reverse_map, parent_color, answer)
  answer << reverse_map[parent_color]
  reverse_map[parent_color].each do |color|
    if reverse_map.key?(color)
      add_answer(reverse_map, color, answer)
    end
  end
end

def solve_part_2()
  total_bags = {}
  target = "shiny gold"
  parent_bag_pattern = /(^([\w\s\w]+?(?=\sbags\s)).*contain\s)/
  content_rule_pattern = /([0-9]+\s[a-z]+\s[a-z]+)(?=\s[bag|bags])/
  File.open("./question_7_input.txt", "r") do |file|
    file.each_line do |line|
      rule = line.chomp
      parent_color = rule.match(parent_bag_pattern).captures[1]
      content_rule = rule.sub(parent_bag_pattern, "")
      content_bags = content_rule.scan(content_rule_pattern).map do |match|
        amount = match[0].split(" ").first.to_i
        color = match[0].split(" ").last(2).join(" ")

        {
          color: color, amount: amount
        }
      end

      total_bags[parent_color] = content_bags
    end
  end

  p get_total(target, total_bags)

end

def get_total(root, map)
  total = 0
  if map.key?(root)
    map[root].each do |bag|

      total += bag[:amount] + (bag[:amount] * get_total(bag[:color], map))
    end
  end

  total
end

solve_part_1
solve_part_2
