
local fade = {}
fade.time = 0
fade.max = 2
fade.done = false
fade.alpha = 255
fade.reduce = 1
fade.text = 
[[
POWERED BY LOVE
http://love2d.org/
]]
fade.images = {}
fade.font = love.graphics.newFont(20)
fade.normalFont = love.graphics.newFont()

function fade.load(text, max)
	fade.text = text or fade.text
	fade.max = max or fade.max
	fade.time = 0
	fade.alpha = 255
	fade.done = false
end

function fade.addImage(path, id, x, y, size, rot)
	local img = {}
	img.x, img.y = x, y
	img.size = size or 1
	img.rot = rot or 0
	img.id = id
	img.path = love.graphics.newImage(path)
	table.insert(fade.images, img)
end

function fade.removeImage(id)
	for k, v in ipairs(fade.images) do
		if v.id == id then
			v = nil
		end
	end
end

function fade.setFont(font)
	fade.font = font or love.graphics.newFont(20)
end

function fade.setReduce(num)
	fade.reduce = num or 1
end

function fade.draw(baseColor, textColor)
	if fade.alpha <= 0 then else
		love.graphics.setColor(baseColor[1], baseColor[2], baseColor[3], fade.alpha)
		love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())
		love.graphics.setColor(textColor[1], textColor[2], textColor[3], fade.alpha)
		love.graphics.setFont(fade.font)
		love.graphics.print(fade.text, love.window.getWidth() / 2 - fade.font:getWidth(fade.text) / 2, love.window.getHeight() / 2 - fade.font:getHeight(fade.text) / 2 )
		love.graphics.setFont(fade.normalFont)
		for k, v in ipairs(fade.images) do
			love.graphics.setColor(255, 255, 255, fade.alpha)
			love.graphics.draw(v.path, v.x, v.y, v.rot, v.size)
		end
	end
end

function fade.update(dt)
	if not fade.done then
		fade.time = fade.time + 0.8 * dt
	end
	if math.floor(fade.time) >= fade.max then
		if fade.alpha <= 0 then 
			fade.done = true
		else
			fade.alpha = fade.alpha - fade.reduce
		end
	end
end

return fade
