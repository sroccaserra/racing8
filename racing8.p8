pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
-- main
local world
local player

local v_max = 2
local acc = 2
local brake = .5
local radius = 4

function _init()
 world = {}
 world.t = time()
 world.dt = 0

 player = {}
 player.c = 11
 player.x = 10
 player.y = 10
 player.a = 0
 player.v = 0
 
 input = {}
 input.left = false
 input.right = false
 input.forward = false
end

function _draw()
 cls()
 draw_player()
 draw_debug()
end

function _update60()
 update_t()

 input.left = btn(0)
 input.right = btn(1)
 input.forward = btn(5)

 update_player()
end

-->8
-- draw

function draw_player()
 local x, y = player.x, player.y
 local r = radius
 local a = player.a
 local dx = r*cos(a)
 local dy = r*sin(a)
 local x_2,y_2 = x+dx,y+dy
 
 line(x-dy/2,y+dx/2,x+dy/2,y-dx/2,player.c)
 line(x-dy/2+dx,y+dx/2+dy,x+dy/2+dx,y-dx/2+dy,player.c)
 line(x-dy/2-dx,y+dx/2-dy,x+dy/2-dx,y-dx/2-dy,player.c)

 dx_1, dy_1 = -dy/2,dx/2 
 dx_2, dy_2 = dy/2,-dx/2 

 line(x-dx+dx_1,y-dy+dy_1,x+dx+dx_1,y+dy+dy_1,player.c)
 line(x-dx+dx_2,y-dy+dy_2,x+dx+dx_2,y+dy+dy_2,player.c)
end

function draw_debug()
end

-->8
-- update

function update_player()
 local da = 0
 local dt = world.dt
 if input.left then
  da = dt/2
 elseif input.right then
  da = -dt/2
 end
 player.a += da
 
 if input.forward then
  player.v = min(v_max, player.v+acc*dt)
 else
  player.v = max(0, player.v-brake*dt)
 end

 local a = player.a
 local v = player.v
 
 player.x += v*cos(a)
 player.y += v*sin(a)
 
 player.x = player.x % 128
 player.y = player.y % 128
end

function update_t()
 local _t = time()
 world.dt = _t - world.t
 world.t = _t
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
