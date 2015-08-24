-- shortcuts
local la = love.audio
local lg = love.graphics

arc = {}

local _key,_,_ = unpack(require(arc_path .. 'input'))

-- config
arc.cfg = {
	msg_spd = 10, 		        -- chars/sec. message speed
	msg_tanim = 0,		    -- sec. duration of message box open/close animation
	msg_tscroll = 0.2,	        -- sec. duration of message scroll animation
	msg_tblink = 1,	        -- sec. period of blinker
	msg_txt_shdw = true,	    -- boolean. true: use text shadow, false: don't use
  msg_nc_short_pause = 1,    -- number. number of characters wait for short pause
  msg_nc_long_pause = 100,    -- number. number of characters wait for short pause
	key_wait0 = .4,		        -- sec. initial wait for directional buttons
	key_wait = .1,		        -- sebsequent wait for directional buttons
	cur_dx = 3,		            -- delta x,y of text wrt cursor right edge
	cur_dy = -2
}

-- colors
arc.col = {
	white = {215,232,148,255},
	black = {0,0,0},
	gray = {128,128,128},
	name = {255,255,0},
	shadow = {0,0,0,192},
	window = {82,127,57,255},
	mred = {255,128,128},
	mgreen = {128,255,128},
	mblue = {128,192,255},
  mpurple = {192,128,255}
}

-- font
arc.fn = {}
arc.fn.f = lg.newFont('assets/fonts/Pokemon_GB.ttf', 14)
arc.fn.h = lg.getHeight()/3
arc.fn.w = function(s) return windowWidth end
print(arc.fn.w)
lg.setFont(arc.fn.f)

-- keys
arc.btn = {
	ent = 'e',
	esc = 'x',
	kp = ''
}
arc.key = {
	u = _key:new('up'),
	r = _key:new('right'),
	d = _key:new('down'),
	l = _key:new('left')
}

-- images
arc.img = {
	-- cursor = lg.newImage('assets/images/cursor.png'),
	blinker = lg.newImage('assets/images/press.png')
}

-- sound effects
arc.sfx = {
}

-- process directional keys
function arc.check_keys(dt)
    for k,_ in pairs(arc.key) do
        arc.key[k]:check(dt)
    end
end

-- update last key pressed
function arc.set_key(k)
	arc.btn.kp = k
end

-- clears last key pressed
function arc.clear_key()
	arc.btn.kp = ''
end
