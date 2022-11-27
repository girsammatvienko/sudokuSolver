MATRIX_ROW = 9          
MATRIX_COLUMN = 9       
SUB_MATRIX = 3 # 3*3 box

#Function checks whether the given matrix is a valid sudoku or not. 
def is_conditions_meet (matrix, row, column, inumber)

    #Check if this row contains the insertig number
    for i in 0..MATRIX_ROW - 1 do 
        if matrix[row][i] == inumber
            return false
        end
    end

    #Check if this column contains the insertig number
    for i in 0..MATRIX_COLUMN - 1 do
        if matrix[i][column] == inumber
            return false
        end
    end

    # Check if we find the same num
    # in the particular 3*3 matrix
    startRow = row - row % SUB_MATRIX
    startCol = column - column % SUB_MATRIX
    for i in 0..SUB_MATRIX - 1 do
        for j in 0..SUB_MATRIX - 1 do
            if (matrix[i + startRow][j + startCol] == inumber)
                return false
            end
        end
    end

    # all condition are meet
    true
end

def solve_sudoky(matrix, row, column)

    #if we have reached the 8th row and 9th column
    # Exit condition
    if (row == MATRIX_ROW-1 && column == MATRIX_COLUMN)
        return true
    end

    if column == MATRIX_COLUMN 
        column = 0
        row += 1
    end

    if (matrix[row][column] != 0)
        return solve_sudoky(matrix, row, column + 1)
    end

    for digit in 1..9 do
        if (is_conditions_meet(matrix, row, column, digit))
            matrix[row][column] = digit

            if (solve_sudoky(matrix, row, column + 1))
                return true
            end
        end

        # removing the assigned num , since our
        # assumption was wrong , and we go for next
        # assumption with diff num value
        matrix[row][column] = 0
    end
    
    # not found assumption
    false
end

def read_from_file(grid, filename)
    file = File.open(filename)

    i = 0
    while i < 9 do
        line = file.readline.to_s.split(" ")
        j = 0
        for value in line do
            grid[i][j] = value.to_i
            j += 1
        end
        i += 1
    end

    file.close
    grid
end


def print_matrix(matrix)
    for i in 0..MATRIX_ROW - 1 do
        for j in 0..MATRIX_COLUMN - 1 do
            print "#{matrix[i][j]} "
        end
        puts 
    end
    puts
end


grid2 = Array.new(9) {Array.new(9)}
read_from_file(grid2, "sudoku/sudoky_sources.txt")
grid1 = [[ 3, 0, 6, 5, 0, 8, 4, 0, 0 ],
                         [ 5, 2, 0, 0, 0, 0, 0, 0, 0 ],
                         [ 0, 8, 7, 0, 0, 0, 0, 3, 1 ],
                         [ 0, 0, 3, 0, 1, 0, 0, 8, 0 ],
                         [ 9, 0, 0, 8, 6, 3, 0, 0, 5 ],
                         [ 0, 5, 0, 0, 9, 0, 6, 0, 0 ],
                         [ 1, 3, 0, 0, 0, 0, 2, 5, 0 ],
                         [ 0, 0, 0, 0, 0, 0, 0, 7, 4 ],
                         [ 0, 0, 5, 2, 0, 6, 3, 0, 0 ] ]



puts "== TEST #1 == read from array"
puts "<#1> start martix =>"
print_matrix(grid1)
puts "<#1> solve matrix =>"
solve_sudoky(grid1, 0, 0)
print_matrix(grid1)

puts "===================="

puts "== TEST #2 == read from file"
puts "<#2> start martix =>"
print_matrix(grid2)
puts "<#2> solve matrix =>"
solve_sudoky(grid2, 0, 0)
print_matrix(grid2)
