local socket = require "socket"
local images = {}
local states = {}
local address, port = "69.143.246.139", 25564
local pressed_array = {}
local translate = {
  ["a"] = "triangle",
  ["s"] = "circle",
  ["x"] = "cross",
  ["z"] = "square",
  ["up"] = "up",
  ["down"] = "down",
  ["left"] = "left",
  ["right"] = "right",
  ["c"] = "select",
  ["v"] = "start",
  ["1"] = "l1",
  ["2"] = "r1",
  ["3"] = "l2",
  ["4"] = "r2",
}

function love.load()
  sock = socket.udp()
  sock:setpeername(address, port)
  images.controller = love.graphics.newImage("game-console-controller-outline-hi.png")
  print(address, port)
end

function love.update()
end

function love.draw()
  love.graphics.draw(images.controller, 0, 0)
end

function love.keypressed(key, isrepeat)
  if not isrepeat and translate[key] ~= nil then
    if pressed_array[key] == nil then
      pressed_array[key] = true
    end
    local str = ""
    for k,v in pairs(pressed_array) do
      if v == true then
        if str == "" then
          str = translate[k]
        else
          str = str .. "," .. translate[k]
        end
      end
    end
    print(str)
    sock:send(str)
  end
end

function love.keyreleased(key, isrepeat)
  if not isrepeat and translate[key] ~= nil then
    if pressed_array[key] == true then
      pressed_array[key] = nil
    end
    local str = ""
    for k,v in pairs(pressed_array) do
      if v == true then
        if str == "" then
          str = translate[k]
        else
          str = str .. "," .. translate[k]
        end
      end
    end
    print(str)
    sock:send(str)
  end
end

