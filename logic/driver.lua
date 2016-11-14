local Driver = {}
BoardHandler = require("logic.boardHandler")

Driver.turn = 0

Driver.x, Driver.y = 0, 0
Driver.message = ""

Driver.colors = {}
Driver.colors[1] = function () return 0, 0, 255, 255 end
Driver.colors[2] = function () return 255, 0, 0, 255 end

function Driver.mousePressed(x, y, button, is_touch)
  if x >= GAME_START_X and x <= GAME_START_X + GAME_WIDTH then
    BoardHandler.checkClick(x, y, button)
  end
end

function Driver.touchpressed(id, x, y, pressure)
  
end

function Driver.keyPressed(key, code, is_repeat)
  if (key == "escape") then
    love.event.quit()
  end
end

function Driver.load()
end

function Driver.update(dt)
  print(Driver.turn)
  Driver.x, Driver.y = love.mouse.getPosition()
  Driver.message = string.format("LOC: %d", BoardHandler.usable)
  BoardHandler.update(dt)
end

function Driver.draw()
  local r, g, b, a = love.graphics.getColor()
  
  love.graphics.setColor(255, 255, 255, 255)
  BoardHandler.draw()
  
  --love.graphics.setColor(0, 255, 255, 127)
  --love.graphics.line(0, love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight() / 2)
  --love.graphics.line(love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())
  
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("(" .. Driver.x .. ", " .. Driver.y .. ")")
  love.graphics.print(Driver.message, 0, 15)
  
  love.graphics.setColor(r, g, b, a)
end

return Driver