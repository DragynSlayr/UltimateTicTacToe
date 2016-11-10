local BoardHandler = {}
Board = require("logic.board")

BoardHandler.boards = {}
local index = 1
for i = 0, 2 do
  for j = 0, 2 do
    BoardHandler.boards[index] = Board.new(i, j)
    index = index + 1
  end
end

function BoardHandler.checkClick(x, y, button)
  if button == 1 then
    local row = y / (SMALL_CELL_SIZE + BIG_BORDER_SIZE)
    local column = (x - GAME_START_X) / (SMALL_CELL_SIZE + BIG_BORDER_SIZE)
    
    row = math.floor(row)
    column = math.floor(column)
    
    print(row, column)
  end
end

function BoardHandler.update(dt)
  for i = 1, #BoardHandler.boards do
    BoardHandler.boards[i]:update(dt)
  end
end

function BoardHandler.drawBoard()
  love.graphics.setColor(127, 127, 127, 127)
  
  local width = love.graphics.getLineWidth()
  love.graphics.setLineWidth(1)
  
  local x = GAME_START_X - (SMALL_CELL_SIZE / 2)
  local y = GAME_START_Y + (BIG_CELL_SIZE / 2) + BIG_BORDER_SIZE
  love.graphics.line(x, y, x + GAME_WIDTH + SMALL_CELL_SIZE, y)
  
  y = GAME_START_Y + (BIG_CELL_SIZE * 1.5) + (BIG_BORDER_SIZE * 2) 
  love.graphics.line(x, y, x + GAME_WIDTH + SMALL_CELL_SIZE, y)
  
  x = GAME_START_X + BIG_CELL_SIZE + BIG_BORDER_SIZE
  love.graphics.line(x, 0, x, GAME_HEIGHT)
  
  x = GAME_START_X + (BIG_CELL_SIZE * 2) + (BIG_BORDER_SIZE * 2)
  love.graphics.line(x, 0, x, GAME_HEIGHT)
  
  love.graphics.setLineWidth(width)
end

function BoardHandler.draw()
  BoardHandler.drawBoard()
  
  love.graphics.setColor(255, 255, 255, 255)
  for i = 1, #BoardHandler.boards do
    BoardHandler.boards[i]:draw()
  end
end

return BoardHandler