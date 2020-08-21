# usage: ruby life.rb
# For each ENTER KEY press, you get one new generation

# Each generation, a cell C is alive 1 or dead 0.
# In the next generation each cell C is alice or dead
# depending on a count of its neighbours N
#
#   Now Neighbors           Next
#   --- ---------           --------------
#   1   0,1             ->  0  # Lonely
#   1   4,5,6,7,8       ->  0  # Overcrowded
#   1   2,3             ->  1  # Lives
#   0   3               ->  1  # It takes three to give birth!
#   0   0,1,2,4,5,6,7,8 ->  0  # Barren
#

# gem install os

def clearScreen
    print "\033[2J"
end

def life(rows, cols, some, generations) 
    now = []
    rows.times {
        row = []
        cols.times {
            if rand < some
                row.push(1)
            else
                row.push(0)
            end
        }
        now.push(row)
    }
    live(now, rows, cols, generations)
end

def has_neighbor(a, r, c, rows, cols)
    if r >= 0 && r < rows && c >= 0 && c < cols && a[r][c] == 1
        return 1
    else
        return 0
    end
end

def live(a, rows, cols, gen)
    if (gen < 1)
        return 0
    end

    # Print the current generation
    clearScreen
    puts "Generation #{gen}"
    for r in (0..(rows-1)).to_a do
        for c in (0..(cols-1)).to_a do
            if a[r][c] == 1
                putc "o"
            else 
                putc " "
            end
        end
        puts ""
    end



    # Generate the next generation
    b = []
    rows.times {
        row = []
        cols.times {
            row.push(0)
        }
        b.push(row)
    }
    b[r][c] = a[r][c]
    for r in (0..(rows-1)).to_a do
        for c in (0..(cols-1)).to_a do
            neighbours = 0
            neighbours = neighbours + has_neighbor(a, r, c-1, rows, cols)
            neighbours = neighbours + has_neighbor(a, r, c+1, rows, cols)
            neighbours = neighbours + has_neighbor(a, r-1, c-1, rows, cols)
            neighbours = neighbours + has_neighbor(a, r-1, c, rows, cols)
            neighbours = neighbours + has_neighbor(a, r-1, c+1, rows, cols)
            neighbours = neighbours + has_neighbor(a, r+1, c-1, rows, cols)
            neighbours = neighbours + has_neighbor(a, r+1, c, rows, cols)
            neighbours = neighbours + has_neighbor(a, r+1, c+1, rows, cols)
            b[r][c] = a[r][c]
            if a[r][c] == 0
                if neighbours == 3
                    b[r][c] = 1
                end
            else
                if !(neighbours == 2 || neighbours == 3)
                    b[r][c] = 0
                end
            end
        end
    end
    print "Press ENTER to continue"
    gets
    live(b, rows, cols, gen - 1)
end

life(5, 5, 0.619, 200)
