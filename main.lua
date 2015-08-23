local sti = require "lib/sti"

arc_path = 'lib/arc/'
require(arc_path .. 'arc')
_navi = require(arc_path .. 'navi')

function love.load()

  music = love.audio.newSource("assets/sounds/dark.wav", "stream")
  music:setLooping(true)
  love.audio.play(music)

  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  love.physics.setMeter(8)

  map = sti.new("main_map.lua")
  world = love.physics.newWorld(0, 0)

  collision = map:initWorldCollision(world)

  map:addCustomLayer("Sprite Layer", 2)

  alice_spr = love.graphics.newImage("assets/images/alice_bed.png")
  alice_spr:setFilter('nearest', 'nearest')
  august_spr = love.graphics.newImage("assets/images/august.png")
  august_spr:setFilter('nearest', 'nearest')
  august_anim = {
    up = {
      love.graphics.newQuad(32, 0, 16, 16, 64, 32)
    },
    down = {
      love.graphics.newQuad(0, 0, 16, 16, 64, 32)
    },
    left = {
      love.graphics.newQuad(48, 0, 16, 16, 64, 32)
    },
    right = {
      love.graphics.newQuad(16, 0, 16, 16, 64, 32)
    }
  }

  local spriteLayer = map.layers["Sprite Layer"]
  spriteLayer.sprite = {
    image = august_anim["down"][1],
    x = 16 * 25,
    y = 16 * 75,
    -- change w & h to radius or something
    w = 8,
    h = 8,
    reached_end = true,
    movement_locked = false,
    r = 0
  }
  spriteLayer.alice = {
    image = alice_spr,
    x = 16 * 25,
    y = 16 * 75,
    w = 32,
    h = 16,
    r = 0
  }


  spriteLayer.sprite.body = love.physics.newBody(world, spriteLayer.sprite.x/2,
                                                 spriteLayer.sprite.y/2,
                                                 "dynamic")
  spriteLayer.sprite.body:setLinearDamping(10)
  spriteLayer.sprite.body:setFixedRotation(true)

  spriteLayer.sprite.shape = love.physics.newRectangleShape(14, 14)
  spriteLayer.sprite.fixture = love.physics.newFixture(spriteLayer.sprite.body,
                                                       spriteLayer.sprite.shape)

  function spriteLayer:update(dt)

  end

  function spriteLayer:draw()
    local x = math.floor(self.sprite.x)
    local y = math.floor(self.sprite.y)
    local r = self.sprite.r
    love.graphics.draw(august_spr, self.sprite.image, x, y, r, 1, 1, 8, 8)
    if self.sprite.reached_end then
      love.graphics.draw(self.alice.image, 119 * 8, 131 * 8, r, 1, 1, w, h)
    end
  end

  msgs_dinner = {}
  msgs_dinner[1] = _navi:new("My first date with\n\nhim.", {box_anim=false})
  msgs_dinner[2] = _navi:new("I'll always remember\n\nthat night...", {box_anim = false})
  msgs_dinner[3] = _navi:new('...but not because\n\nit was romantic!', {box_anim = false})
  msgs_dinner[4] = _navi:new('In the middle of\n\neating he started', {box_anim=false})
  msgs_dinner[5] = _navi:new('to sneeze uncontrol-\n\nlably and knocked', {box_anim=false})
  msgs_dinner[6] = _navi:new('his drink over.', {box_anim=false})
  msgs_dinner[7] = _navi:new("I couldn't stop lau-\n\nghing for the rest", {box_anim = false})
  msgs_dinner[8] = _navi:new("of the evening. I\n\nhaven't seen his", {box_anim = false})
  msgs_dinner[9] = _navi:new("face so red since!", {box_anim = false})
  msgs_dinner[10] = _navi:new('Somehow, that was the\n\nmost charming thing', {box_anim = false})
  msgs_dinner[11] = _navi:new('he could have done.', {box_anim = false})

  msgs_park = {}
  msgs_park[1] = _navi:new("We came here often.", {box_anim=false})
  msgs_park[2] = _navi:new("He said he enjoyed\n\nwatching people in", {box_anim = false})
  msgs_park[3] = _navi:new('the park. I called\n\nhim creepy, but', {box_anim = false})
  msgs_park[4] = _navi:new('really, I liked it\n\ntoo. We would sit', {box_anim=false})
  msgs_park[5] = _navi:new('with our fingers\n\ninterlocked and', {box_anim=false})
  msgs_park[6] = _navi:new('share silence\n\ntogether. My head', {box_anim=false})
  msgs_park[7] = _navi:new("usually found its\n\nway to his shoulder.", {box_anim = false})
  msgs_park[8] = _navi:new("He was warm.", {box_anim = false})

  msgs_hospital = {}
  msgs_hospital[1] = _navi:new("I hated him seeing\n\nme like that.", {box_anim=false})
  msgs_hospital[2] = _navi:new("I told him he wasn't\n\nallowed to see me", {box_anim = false})
  msgs_hospital[3] = _navi:new("without my face on.\n\nHe'd just rub my", {box_anim = false})
  msgs_hospital[4] = _navi:new('hair and smile.\n\nHe always came.', {box_anim=false})
  msgs_hospital[5] = _navi:new('When it started to\n\nget worse, I', {box_anim=false})
  msgs_hospital[6] = _navi:new('became more afraid.\n\nOne day, he came', {box_anim=false})
  msgs_hospital[7] = _navi:new("dressed in a monk\n\nrobe and pretended", {box_anim = false})
  msgs_hospital[8] = _navi:new("to cast healing\n\nspells on me.", {box_anim = false})
  msgs_hospital[9] = _navi:new("I don't know why,\n\nbut I got angry.", {box_anim = false})
  msgs_hospital[10] = _navi:new('I asked him if he\n\nknew how serious my', {box_anim = false})
  msgs_hospital[11] = _navi:new('condition was. I\n\nfelt overwhelmed,', {box_anim = false})
  msgs_hospital[12] = _navi:new('I started crying.\n\nThen he hugged me', {box_anim = false})
  msgs_hospital[13] = _navi:new('tightly for what felt\n\nlike a lifetime.', {box_anim = false})
  msgs_hospital[14] = _navi:new("I cried as he\n\nheld me.", {box_anim = false})

  msgs_bedroom = {}
  msgs_bedroom[1] = _navi:new("I had never been with\n\nanyone like him.", {box_anim=false})
  msgs_bedroom[2] = _navi:new("Any hesitations I had\n\nhe could wash away", {box_anim = false})
  msgs_bedroom[3] = _navi:new('in an instant. I felt\n\nsafe. I felt happy.', {box_anim = false})
  msgs_bedroom[4] = _navi:new('The best days were\n\nthe ones where we', {box_anim=false})
  msgs_bedroom[5] = _navi:new('stayed in bed and\n\nwithout a care in', {box_anim=false})
  msgs_bedroom[6] = _navi:new("the world. Content,\n\nI'd ask if we", {box_anim=false})
  msgs_bedroom[7] = _navi:new("could have every day\n\nbe like these.", {box_anim = false})
  msgs_bedroom[8] = _navi:new("I'm not going\n\nanywhere, he said.", {box_anim = false})
  msgs_bedroom[9] = _navi:new("A chaque oiseau\n\nson nid est beau,", {box_anim = false})
  msgs_bedroom[10] = _navi:new('I said.', {box_anim = false})

  msgs_forest = {}
  msgs_forest[1] = _navi:new("Skidmarks.", {box_anim=false})
  msgs_forest[2] = _navi:new("The guard rails on\n\nthe Parkway didn't", {box_anim = false})
  msgs_forest[3] = _navi:new('do a thing. Not at\n\nthat speed, the', {box_anim = false})
  msgs_forest[4] = _navi:new('police told me.\n\nI was at work when', {box_anim=false})
  msgs_forest[5] = _navi:new('it happened. I spent\n\nthe rest of the', {box_anim=false})
  msgs_forest[6] = _navi:new('day sitting under\n\na tree next to what', {box_anim=false})
  msgs_forest[7] = _navi:new("was left of his car.\n\nI didn't cry.", {box_anim = false})
  msgs_forest[8] = _navi:new("I didn't do anything.", {box_anim = false})
  msgs_forest[9] = _navi:new("I wondered if I'd\n\nwake up the next", {box_anim = false})
  msgs_forest[10] = _navi:new("time I fell asleep.", {box_anim = false})

  msgs_end = {}
  msgs_end[1] = _navi:new("It was only a\n\nmatter of time before", {box_anim=false, skip=false, wait=1})
  msgs_end[2] = _navi:new("my body would\n\ngive up.", {box_anim = false, skip=false, wait=1})
  msgs_end[3] = _navi:new('My only regret is\n\nnot having loved', {box_anim = false, skip=false, wait=1})
  msgs_end[4] = _navi:new('you enough.\n\nI should have taken', {box_anim=false, skip=false, wait=1})
  msgs_end[5] = _navi:new('us to the ends of\n\nthe Earth, I should', {box_anim=false, skip=false, wait=1})
  msgs_end[6] = _navi:new('have made you laugh\n\nmore, I should have', {box_anim=false, skip=false, wait=1})
  msgs_end[7] = _navi:new("rubbed your nose\n\nagainst mine every", {box_anim = false, skip=false, wait=1})
  msgs_end[8] = _navi:new("morning. Mon cher,\n\npas plus de", {box_anim = false, skip=false, wait=1})
  msgs_end[9] = _navi:new("cauchemars.\n\nI know you've been", {box_anim = false, skip=false, wait=1})
  msgs_end[10] = _navi:new('haunting me patiently.\n\nNo more.', {box_anim = false, skip=false, wait=1})
  msgs_end[11] = _navi:new('Now we can go\n\ntogether.', {box_anim = false, skip=false, wait=1})
  msgs_end[12] = _navi:new('My love?', {box_anim = false, skip=false, wait=1})
  msgs_end[13] = _navi:new('Is', {box_anim = false, skip=false, wait=2, msg_spd=6})
  msgs_end[14] = _navi:new('that', {box_anim = false, skip=false, wait=2, msg_spd=4})
  msgs_end[15] = _navi:new('you?...', {box_anim = false, skip=false, wait=2, msg_spd=2})

end

function love.draw()

  love.graphics.scale(3, 3)
  local translateX = 0
  local translateY = 0
  local sprite = map.layers["Sprite Layer"].sprite

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()
  local tx = math.floor(-sprite.x + ww / 2 - 160)
  local ty = math.floor(-sprite.y + wh / 2 - 144)


  love.graphics.push()
	love.graphics.translate(tx, ty)
	map:setDrawRange(-tx, -ty, ww, wh)
  -- note: this no longer accepts scale parameters, thus l.g.scale above
  map:draw()
  draw_event_debug(200, 184, 16, 16)

  love.graphics.setColor(255, 0, 0, 255)
  -- debug, drawing box around collidable tiles
  -- map:drawWorldCollision(collision)
  love.graphics.setColor(255, 0, 0, 255)
  -- debug, drawing box around august
  -- love.graphics.polygon("line", sprite.body:getWorldPoints(sprite.shape:getPoints()))
  love.graphics.pop()
  love.graphics.setColor(255, 255, 255, 255)

  love.graphics.scale(0.5, 0.5)
  if stepping_on_event(200, 184, 16, 8) then
    _navi.play_list(msgs_dinner,-1,225)

  elseif stepping_on_event(41 * 8, 47 * 8, 32, 8) then
    _navi.play_list(msgs_park,-1,225)

  elseif stepping_on_event(109 * 8, 38 * 8, 16, 8) then
    _navi.play_list(msgs_hospital,-1,225)

  elseif stepping_on_event(139 * 8, 87 * 8, 8, 40) then
    _navi.play_list(msgs_bedroom,-1,225)

  elseif stepping_on_event(33 * 8, 123 * 8, 128, 64) then
    _navi.play_list(msgs_forest,-1,225)

  elseif stepping_on_event(117 * 8, 132 * 8, 16, 12) and sprite.reached_end then
    _navi.play_list(msgs_end,-1,225)
    sprite.movement_locked = true
    love.audio.stop(music)
  end

  arc.clear_key()

end

function check_all_events_hit()
  return msgs_dinner[11]:is_over() and
         msgs_park[8]:is_over() and
         msgs_hospital[14]:is_over() and
         msgs_bedroom[10]:is_over() and
         msgs_forest[10]:is_over()
end

function love.update(dt)

  world:update(dt)
  arc.check_keys(dt)

  local sprite = map.layers["Sprite Layer"].sprite
  local down = love.keyboard.isDown

  local x, y = 0, 0

  if check_all_events_hit() then sprite.reached_end = true end

  -- elseifs to stop diagonal movement
  if down("w") or down("up") then
    sprite.image = august_anim["up"][1]
    y = y - 8000
  elseif down("s") or down("down") then
    sprite.image = august_anim["down"][1]
    y = y + 8000
  elseif down("a") or down("left") then
    sprite.image = august_anim["left"][1]
    x = x - 8000
  elseif down("d") or down("right") then
    sprite.image = august_anim["right"][1]
    x = x + 8000
  end

  -- sprite.body:setMass(20)
  if not sprite.movement_locked then
    sprite.body:applyForce(x, y)
  end
  sprite.x, sprite.y = sprite.body:getWorldCenter()

  map:update(dt)

end

function draw_event_debug(event_x, event_y, event_width, event_height)
  love.graphics.setColor(0, 125, 50, 100)
  love.graphics.rectangle("fill", event_x, event_y, event_width,event_height)
  love.graphics.rectangle("line", event_x, event_y, event_width,event_height)
end

function stepping_on_event(event_x, event_y, event_width, event_height)
  local sprite = map.layers["Sprite Layer"].sprite

  if sprite.x - sprite.w < event_x + event_width and
     event_x < sprite.x + sprite.w and
     sprite.y - sprite.h < event_y + event_height and
     event_y < sprite.y + sprite.h then
     return true
  end
  return false
end

function love.keypressed(key)
  arc.set_key(key)
end
