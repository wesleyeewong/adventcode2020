class Node
  attr_reader :value, :next, :prev

  def initialize(value)
    @value = value
  end

  def next=(node)
    @next = node
  end

  def prev=(node)
    @prev = node
  end
end


def solve_part_1()
  east_node = Node.new("E")
  south_node = Node.new("S")
  west_node = Node.new("W")
  north_node = Node.new("N")

  east_node.next=(south_node)
  east_node.prev=(north_node)

  south_node.next=(west_node)
  south_node.prev=(east_node)

  west_node.next=(north_node)
  west_node.prev=(south_node)

  north_node.next=(east_node)
  north_node.prev=(west_node)

  curr_heading = east_node

  x = 0
  y = 0

  File.open("./question_12_input.txt", "r") do |file|
    file.each_line do |line|
      clean = line.chomp
      instruction = clean.split("")[0]
      value = clean.split("")[1..-1].join.to_i

      case instruction
      when "N"
        x += value
      when "S"
        x -= value
      when "E"
        y += value
      when "W"
        y -= value
      when "F"
        case curr_heading.value
        when "N"
          x += value
        when "S"
          x -= value
        when "E"
          y += value
        when "W"
          y -= value
        end
      when "R"
        (1..(value / 90)).each do |_x|
          curr_heading = curr_heading.next
        end
      when "L"
        (1..(value / 90)).each do |_x|
          curr_heading = curr_heading.prev
        end
      end
    end
  end

  p x.abs + y.abs
end

def solve_part_2()

  x = 0
  y = 0

  way_point = [10, 1]

  File.open("./question_12_input.txt", "r") do |file|
    file.each_line.with_index do |line, index|
      clean = line.chomp
      instruction = clean.split("")[0]
      value = clean.split("")[1..-1].join.to_i

      p clean


      case instruction
      when "N"
        way_point[1] += value
      when "E"
        way_point[0] += value
      when "S"
        way_point[1] -= value
      when "W"
        way_point[0] -= value
      when "F"
        x += (way_point[0] * value)
        y += (way_point[1] * value)
      when "R"
        (1..(value / 90)).each do |_x|
          way_point = [way_point[1], -way_point[0]]
        end
      when "L"
        (1..(value / 90)).each do |_x|
          way_point = [-way_point[1], way_point[0]]
        end
      end
      # p way_point
      # p "x: #{x}, y: #{y}"
    end
  end
  p x.abs + y.abs
end

solve_part_1
solve_part_2
