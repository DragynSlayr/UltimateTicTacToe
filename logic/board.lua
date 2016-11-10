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
  
  function board:update(dt)
    self.sprite:update(dt)
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
        char = self.spaces[(j + (i * 3)) + 1]
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