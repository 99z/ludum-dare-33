-- IMPORTS
require('splash')
-- sti: https://github.com/karai17/Simple-Tiled-Implementation
-- handles map loading/drawing from Tiled .lua export
-- also handles collision
local sti = require "lib/sti"
-- navi: https://love2d.org/forums/viewtopic.php?f=5&t=9265
-- library to make text boxes easy and nice
arc_path = 'lib/arc/'
require(arc_path .. 'arc')
_navi = require(arc_path .. 'navi')

function love.load()

  -- yay lua
  lg = love.graphics

  -- game state set to splash initially
  state = "splash"
  windowWidth = lg.getWidth()
  windowHeight = lg.getHeight()

  -- LOADING GRAPHICS & SETTING UP MAP
  title = lg.newImage("assets/images/title.png")

  map = sti.new("assets/mind.lua")
  world = love.physics.newWorld(0, 0)
  love.physics.setMeter(8)

  -- initWorldCollision is part of sti
  -- automatically detects tiles with the "collidable" property set to true
  -- this property can be set in Tiled
  collision = map:initWorldCollision(world)


  -- LOADING AUGUST AND ALICE
  -- sprite layer for august and alice, need to be on top of map
  map:addCustomLayer("Sprite Layer", 2)

  alice_spr = lg.newImage("assets/images/alice_bed.png")
  alice_spr:setFilter('nearest', 'nearest')

  august_spr = lg.newImage("assets/images/august.png")
  august_spr:setFilter('nearest', 'nearest')

  august_anim = {
    up = {
      lg.newQuad(32, 0, 16, 16, 64, 32)
    },
    down = {
      lg.newQuad(0, 0, 16, 16, 64, 32)
    },
    left = {
      lg.newQuad(48, 0, 16, 16, 64, 32)
    },
    right = {
      lg.newQuad(16, 0, 16, 16, 64, 32)
    }
  }

  local spriteLayer = map.layers["Sprite Layer"]
  spriteLayer.august = {
    image = august_anim["down"][1],
    x = 16 * 25,
    y = 16 * 75,
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


  -- setting movement physics and collision on august
  spriteLayer.august.body = love.physics.newBody(world, spriteLayer.august.x/2,
                                                 spriteLayer.august.y/2,
                                                 "dynamic")
  spriteLayer.august.body:setLinearDamping(10)
  spriteLayer.august.body:setFixedRotation(true)

  spriteLayer.august.shape = love.physics.newRectangleShape(14, 14)
  spriteLayer.august.fixture = love.physics.newFixture(spriteLayer.august.body,
                                                       spriteLayer.august.shape)

  function spriteLayer:update(dt)

  end

  function spriteLayer:draw()
    local x = math.floor(self.august.x)
    local y = math.floor(self.august.y)
    local r = self.august.r
    lg.draw(august_spr, self.august.image, x, y, r, 1, 1, 8, 8)
    if self.august.reached_end then
      lg.draw(self.alice.image, 119 * 8, 131 * 8, r, 1, 1, w, h)
    end
  end

  -- LOADING AUDIO
  music = love.audio.newSource("assets/sounds/dark.wav", "stream")
  music:setLooping(true)
  love.audio.play(music)

  -- LOADING MESSAGES
  -- see navi documentation for what this stuff does, it's pretty cool :)
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
  msgs_end[11] = _navi:new("I'll join you now.", {box_anim = false, skip=false, wait=1})
  msgs_end[12] = _navi:new('My love?', {box_anim = false, skip=false, wait=1})
  msgs_end[13] = _navi:new('Is', {box_anim = false, skip=false, wait=2, msg_spd=6})
  msgs_end[14] = _navi:new('that', {box_anim = false, skip=false, wait=2, msg_spd=4})
  msgs_end[15] = _navi:new('you?...', {box_anim = false, skip=false, wait=2, msg_spd=2})

  -- load the beautiful splash screen
  splash.load()

end

function love.draw()

  -- needed for map rendering to scale properly
  lg.scale(3, 3)

  -- messy, but throwing everything game-related inside else so splash gets
  -- rendered before anything else
  if state == "splash" then
    splash.draw()
  else

    local sprite = map.layers["Sprite Layer"].august

    local ww = lg.getWidth()
    local wh = lg.getHeight()
    local tx = math.floor(-sprite.x + ww / 2 - 160)
    local ty = math.floor(-sprite.y + wh / 2 - 144)

    -- from here until lg.pop() is what renders the map as we move
    -- copied from the sti demo ;)
    lg.push()
  	lg.translate(tx, ty)
  	map:setDrawRange(-tx, -ty, ww, wh)
    -- note: this no longer accepts scale parameters, thus l.g.scale above
    map:draw()

    lg.setColor(255, 0, 0, 255)

    -- debug, drawing box around collidable tiles
    -- map:drawWorldCollision(collision)

    -- debug, drawing box around august
    -- lg.polygon("line", sprite.body:getWorldPoints(sprite.shape:getPoints()))
    lg.pop()
    lg.setColor(255, 255, 255, 255)

    -- scaling message boxes a bit smaller
    lg.scale(0.5, 0.5)

    -- play messages corresponding to different event zones
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

end

function love.update(dt)

  -- again, messy, but only doing updates for game if in game state
  if state == "game" then
    reunited()

    world:update(dt)
    arc.check_keys(dt)

    local sprite = map.layers["Sprite Layer"].august
    if check_all_events_hit() then sprite.reached_end = true end

    local down = love.keyboard.isDown

    -- handling movement
    local x, y = 0, 0
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

    sprite.body:setMass(20)
    if not sprite.movement_locked then
      sprite.body:applyForce(x, y)
    end
    sprite.x, sprite.y = sprite.body:getWorldCenter()

    map:update(dt)
  end

end

function love.keypressed(key)
  if key == "return" or key == "e" then
    state = "game"
  end

  arc.set_key(key)
end

-- debug function to draw event zone boundaries
function draw_event_debug(event_x, event_y, event_width, event_height)
  lg.setColor(0, 125, 50, 100)
  lg.rectangle("fill", event_x, event_y, event_width,event_height)
  lg.rectangle("line", event_x, event_y, event_width,event_height)
end

-- determines if august is on top of an event zone
-- generic bounding box logic
function stepping_on_event(event_x, event_y, event_width, event_height)
  local sprite = map.layers["Sprite Layer"].august

  return sprite.x - sprite.w < event_x + event_width and
         event_x < sprite.x + sprite.w and
         sprite.y - sprite.h < event_y + event_height and
         event_y < sprite.y + sprite.h
end

-- ca fait longtemps
function reunited()
  if msgs_end[15]:is_over() then love.event.quit() end
end

-- probably not the least resource-intensive way to do this, but
-- this is run every time love.update is called and determines if
-- august has read through all the messages
function check_all_events_hit()
  return msgs_dinner[11]:is_over() and
         msgs_park[8]:is_over() and
         msgs_hospital[14]:is_over() and
         msgs_bedroom[10]:is_over() and
         msgs_forest[10]:is_over()
end
