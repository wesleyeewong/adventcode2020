# FBFBBFFRLR

def solve_part_1()
  File.open("./question_5_input.txt", "r") do |file|
    ids = []
    seats = (0..127).map do |row|
      Array.new(8)
    end

    file.each_line do |line|
      input = line.chomp
      range = 0..127

      input[0..6].each_char.with_index do |char, index|
        half = (range.size / 2) - 1
        half_way = range.to_a[half]
        case char
        when "F"
          range = (range.first..half_way)
        when "B"
          range = ((half_way + 1)..range.last)
        end
      end

      row = range.first

      range = (0..7)

      input[7..9].each_char do |char|
        half = (range.size / 2) - 1
        half_way = range.to_a[half]
        case char
        when "L"
          range = (range.first..half_way)
        when "R"
          range = ((half_way + 1)..range.last)
        end
      end

      column = range.first

      seat_id = (row * 8) + column

      seats[row][column] = seat_id
      ids << seat_id

    end

    pretty_print_seats(seats)
    p ids.max
  end
end

def pretty_print_seats(seats)

  seats.each do |row|
    uniq = row.uniq

    if uniq.size > 1
      p row.map { |column| column.nil? ? "EMPTY" : column }
    end
  end

end

def solve_part_2()
end

solve_part_1()
solve_part_2()
