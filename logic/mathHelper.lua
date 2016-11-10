local MathHelper = {}

function MathHelper.load()
  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  
  MathHelper.random = math.random
end

function MathHelper.getDistanceBetween(a, b)
  local x_dist = a.x - b.x
  local y_dist = a.y - b.y
  
  x_dist = x_dist * x_dist
  y_dist = y_dist * y_dist
  
  return math.sqrt(x_dist + y_dist)
end

MathHelper.load()

return MathHelper