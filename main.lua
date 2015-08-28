local socket = require "socket"
local images = {}
local states = {}
local buttons = {}
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
  print(address, port)


  -- TODO this needs MUCH MORE WORK
  for key in translate.keys do
    buttons[translate[key]] = {
      onclick = function()
        remap()
      end
    }
  end
end

function love.update()
end

function love.draw()
  -- TODO draw buttons
end

function love.mousepressed(x, y, button)
  -- TODO Button onclicks
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

function remap(old, new, key)
  if old == nil and key ~= nil then
    translate[new] = key
  elseif old ~= nil and key == translate[old] then
    translate[new] = translate[old]
    translate[old] = nil
  else
    print(string.format("error in remap(%s, %s, %s)", old, new, key))
  end
end
