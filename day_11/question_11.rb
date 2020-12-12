def solve_part_2()
  count_matrix = []
  symbol_matrix = []
  symbol_location = []
  available_rows = []

  File.open("./question_11_input.txt", "r") do |file|
    file.each_line.with_index do |line, row_index|
      row = line.chomp.split("")

      symbol = []
      count = []
      row_location = []

      row.each_with_index do |spot, index|
        if spot == "L"
          spot = "#"
        end

        symbol << spot
        count << 0

        if spot == "#"
          row_location << index
        end
      end

      available_rows << row_index
      symbol_location << row_location
      count_matrix << count
      symbol_matrix << symbol
    end
  end

  row_size = available_rows.size
  column_size = symbol_matrix[0].size

  indexing = [
    [0, 1], [0, -1], [1, 0], [1, 1], [1, -1], [-1, 0], [-1, 1], [-1, -1]
  ]

  symbol_location.each_with_index do |row, row_index|
    row.each do |column|
      indexing.each do |indexing_points|
        found = false
        curr_row = row_index
        curr_col = column
        while !found && (curr_row > -1 && curr_row < row_size) && (curr_col > -1 && curr_col < column_size)
          curr_row += indexing_points[0]
          curr_col += indexing_points[1]
          if available_rows.include?(curr_row) && symbol_location[curr_row].include?(curr_col)
            found = true
            count_matrix[row_index][column] += 1
          end
        end
      end
    end
  end

  change = true
  while change
    change = false
    occupy_index = []
    empty_index = []

    symbol_location.each_with_index do |row, row_index|
      row.each do |column|
        if count_matrix[row_index][column] >= 5 && symbol_matrix[row_index][column] == "#"
          change = true
          occupy_index << [row_index, column]
        elsif count_matrix[row_index][column] == 0 && symbol_matrix[row_index][column] == "L"
          change = true
          empty_index << [row_index, column]
        end
      end
    end

    occupy_index.each do |change_points|
      symbol_matrix[change_points[0]][change_points[1]] = "L"
    end

    empty_index.each do |change_points|
      symbol_matrix[change_points[0]][change_points[1]] = "#"
    end

    symbol_location.each_with_index do |row, row_index|
      row.each do |column|
        count_matrix[row_index][column] = 0
        indexing.each do |indexing_points|
          found = false
          curr_row = row_index
          curr_col = column
          while !found && (curr_row > -1 && curr_row < row_size) && (curr_col > -1 && curr_col < column_size)
            curr_row += indexing_points[0]
            curr_col += indexing_points[1]
            if available_rows.include?(curr_row) && symbol_location[curr_row].include?(curr_col)
              if symbol_matrix[curr_row][curr_col] == "#"
                count_matrix[row_index][column] += 1
              end
              found = true
            end
          end
        end
      end
    end

  end
  pretty_print(symbol_matrix)
  pretty_print(count_matrix)

  count = 0
  symbol_location.each_with_index do |row, row_index|
    row.each do |column|
      count += 1 if symbol_matrix[row_index][column] == "#"
    end
  end

  p count
end

def pretty_print(matrix)
  matrix.each do |row|
    row.each do |spot|
      print spot
      STDOUT.flush
    end
  p "   |"
  end
end


def solve_part_1()
  count_matrix = []
  symbol_matrix = []
  symbol_location = []
  available_rows = []

  File.open("./question_11_input_sample.txt", "r") do |file|
    file.each_line.with_index do |line, row_index|
      row = line.chomp.split("")

      symbol = []
      count = []
      row_location = []

      row.each_with_index do |spot, index|
        symbol << spot
        count << 0

        if spot == "L"
          row_location << index
        end
      end

      available_rows << row_index
      symbol_location << row_location
      count_matrix << count
      symbol_matrix << symbol
    end
  end

  indexing = [
    [0, 1], [0, -1], [1, 0], [1, 1], [1, -1], [-1, 0], [-1, 1], [-1, -1]
  ]

  symbol_location.each_with_index do |row, row_index|
    row.each do |column|
      if symbol_matrix[row_index][column] == "L"
        symbol_matrix[row_index][column] = "#"

        indexing.each do |indexing_points|
          neighbor_row = row_index + indexing_points[0]
          if available_rows.include?(neighbor_row) &&
              symbol_location[neighbor_row].include?(column + indexing_points[1])
            count_matrix[neighbor_row][column + indexing_points[1]] += 1
          end
        end
      end
    end
  end

  change = true
  while change
    change = false
    occupy_index = []
    empty_index = []

    symbol_location.each_with_index do |row, row_index|
      row.each do |column|
        if count_matrix[row_index][column] >= 5 && symbol_matrix[row_index][column] == "#"
          change = true
          occupy_index << [row_index, column]
        elsif count_matrix[row_index][column] == 0 && symbol_matrix[row_index][column] == "L"
          change = true
          empty_index << [row_index, column]
        end
      end
    end

    occupy_index.each do |change_points|
      symbol_matrix[change_points[0]][change_points[1]] = "L"

      indexing.each do |indexing_points|
        neighbor_row = change_points[0] + indexing_points[0]
        if available_rows.include?(neighbor_row) &&
            symbol_location[neighbor_row].include?(change_points[1] + indexing_points[1])
          count_matrix[neighbor_row][change_points[1] + indexing_points[1]] -= 1
        end
      end
    end

    empty_index.each do |change_points|
      symbol_matrix[change_points[0]][change_points[1]] = "#"

      indexing.each do |indexing_points|
        neighbor_row = change_points[0] + indexing_points[0]
        if available_rows.include?(neighbor_row) &&
            symbol_location[neighbor_row].include?(change_points[1] + indexing_points[1])
          count_matrix[neighbor_row][change_points[1] + indexing_points[1]] += 1
        end
      end
    end

    # pretty_print(symbol_matrix)
    # pretty_print(count_matrix)
    # p "###################"

    # binding.irb
  end
  pretty_print(symbol_matrix)
  pretty_print(count_matrix)

  count = 0
  symbol_location.each_with_index do |row, row_index|
    row.each do |column|
      count += 1 if symbol_matrix[row_index][column] == "#"
    end
  end

  p count
end

solve_part_1
solve_part_2
