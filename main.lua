require("logic.constants")
MathHelper = require("logic.mathHelper")
SpriteHandler = require("logic.spriteHandler")
Driver = require("logic.driver")

-- Register mouse events
love.mousepressed = Driver.mousePressed

--Register key events
love.keypressed = Driver.keyPressed

-- Register love events
love.load = Driver.load
love.update = Driver.update
love.draw = Driver.draw

--Change background color
love.graphics.setBackgroundColor(0, 0, 0, 255)