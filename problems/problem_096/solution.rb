#!/usr/bin/env ruby

sum = 0

File.open(File.join(File.dirname(__FILE__), '..', 'data', 'sudoku.txt'), 'r') do |file|
  loop do
    break if file.gets.nil?

    col = [0] * 9
    row = [0] * 9
    box = [0] * 9

    board = []
    9.times do |row_num|
      file.gets.strip.split(//).each_with_index do |ch, col_num|
        num = ch.to_i
        board << num
        next if num == 0
        num_mask = 1 << (num - 1)
        row[row_num] |= num_mask
        col[col_num] |= num_mask
        box[row_num / 3 * 3 + col_num / 3] |= num_mask
      end
    end

    def set_value(board, box, col, row, index)
      return true if index > 80
      return set_value(board, box, col, row, index + 1) unless board[index] == 0
      row_num, col_num = index/ 9, index % 9
      available_mask = 511 & ~box[row_num / 3 * 3 + col_num / 3] & ~row[row_num] & ~col[col_num]
      1.upto(9) do |num|
        num_mask = 1 << (num - 1)
        next if num_mask & available_mask == 0
        board[index] = num
        box[row_num / 3 * 3 + col_num / 3] |= num_mask
        row[row_num] |= num_mask
        col[col_num] |= num_mask
        return true if set_value(board, box, col, row, index + 1)
        board[index] = 0
        box[row_num / 3 * 3 + col_num / 3] ^= num_mask
        row[row_num] ^= num_mask
        col[col_num] ^= num_mask
      end
      false
    end

    set_value(board, box, col, row, 0)

    sum += board[0...3].join.to_i
  end
end

puts sum
