local Board = {}

Board.small_x = SpriteHandler.loadSprite("small_x.tga", 1, 1)
Board.small_o = SpriteHandler.loadSprite("small_o.tga", 1, 1)
Board.big_x = SpriteHandler.loadSprite("big_x.tga", 1, 1)
Board.big_o = SpriteHandler.loadSprite("big_o.tga", 1, 1)
Board.blank = SpriteHandler.loadSprite("blank.tga", 1, 1)
Board.draw_sprite = Board.blank

function Board.new(row, column)
  local board = {}
  
  board.x = GAME_START_X + (row * (BIG_CELL_SIZE + BIG_BORDER_SIZE)) + (BIG_CELL_SIZE / 2) + (BIG_BORDER_SIZE / 2)
  board.y = GAME_START_Y + (column * (BIG_CELL_SIZE + BIG_BORDER_SIZE)) + (BIG_BORDER_SIZE / 2)
  board.sprite = SpriteHandler.loadSprite("board.tga", 1, 1)
  board.spaces = {0, 0, 0, 0, 0, 0, 0, 0, 0}
  board.over = false
  board.winner = 0
  
  board.red = 255
  board.green = 255
  board.blue = 255
  
  function board:update(dt)
    self.over, self.winner = self:checkWinner()
    self.sprite:update(dt)
  end
  
  function board:checkWinner()
    if (self.over) then        
      return true, self.winner
    else
      local full = self:isFull()
      if (not full) then
        for i = 1, 3 do
          if (self.spaces[i] == self.spaces[i + 3] and self.spaces[i + 3] == self.spaces[i + 6] and self.spaces[i + 6] ~= 0) then
            return true, self.spaces[i]
          end
          local j = 1 + (3 * (i - 1))
          if (self.spaces[j] == self.spaces[j + 1] and self.spaces[j + 1] == self.spaces[j + 2] and self.spaces[j + 2] ~= 0) then
            return true, self.spaces[j]
          end
        end
        if (self.spaces[1] == self.spaces[5] and self.spaces[5] == self.spaces[9] and self.spaces[9] ~= 0) then
          return true, self.spaces[1]
        end
        if (self.spaces[3] == self.spaces[5] and self.spaces[5] == self.spaces[7] and self.spaces[7] ~= 0) then
          return true, self.spaces[3]
        end
        return false, self.winner
        --[[
        if (self.spaces[1] == self.spaces[2] and self.spaces[2] == self.spaces[3] and self.spaces[3] ~= 0) then
          return true, self.spaces[3]
        else
          return false, self.winner
        end
        ]]--
      else
        return true, self.winner
      end
    end
  end
  
  function board:isFull()
    for i = 1, #self.spaces do
      if (self.spaces[i] == 0) then
        return false
      end
    end
    return true
  end
  
  function board:getColor()
    if (self.winner == 0) then
      return self.red, self.green, self.blue, 255
    else
      return Driver.colors[self.winner]()
    end
  end
  
  function board:draw()
    SpriteHandler.drawSprite(board.sprite, board.x, board.y)
    if self.over and self.winner > 0 then
      if self.winner == 1 then
        Board.draw_sprite = Board.big_x
      else
        Board.draw_sprite = Board.big_o
      end
      SpriteHandler.drawSprite(Board.draw_sprite, self.x, self.y)
    end
    for i = 0, 2 do
      for j = 0, 2 do
        char = self.spaces[(i + (j * 3)) + 1]
        x = self.x - (SMALL_CELL_SIZE + SMALL_BORDER_SIZE) + (i * (SMALL_CELL_SIZE + SMALL_BORDER_SIZE))
        y = self.y - (SMALL_CELL_SIZE + SMALL_BORDER_SIZE) + (j * (SMALL_CELL_SIZE + SMALL_BORDER_SIZE))
        if char == 0 then
          Board.draw_sprite = Board.blank
        elseif char == 1 then
          Board.draw_sprite = Board.small_x
        else
          Board.draw_sprite = Board.small_o
        end
        SpriteHandler.drawSprite(Board.draw_sprite, x, y)
      end
    end
  end

  return board
end

return Board