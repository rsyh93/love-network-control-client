function love.conf(t)
  t.title = "Playstation client"
  t.version = "0.9.2"

  t.window.icon = nil       -- default
  t.window.width = 600
  t.window.height = 372
  t.window.resizable = true -- default

  t.modules.audio = false
  t.modules.math = false
  t.modules.physics = false

  t.console = false         -- display console on windows
end
