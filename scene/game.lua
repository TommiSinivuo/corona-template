local composer = require("composer")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local player

local function endGame()
   composer.gotoScene("scene.menu", {time = 800, effect = "crossFade"})
end

local function dragPlayer(event)
   local player = event.target
   local phase = event.phase

   if (phase == "began") then
      display.currentStage:setFocus(player)
      player.touchOffsetX = event.x - player.x
      player.touchOffsetY = event.y - player.y
   elseif (phase == "moved") then
      player.x = event.x - player.touchOffsetX
      player.y = event.y - player.touchOffsetY
   elseif (phase == "ended" or phase == "cancelled") then
      display.currentStage:setFocus(nil)
   end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)
   local sceneGroup = self.view
   -- Code here runs when the scene is first created but has not yet appeared on screen
   local endButton = display.newText(sceneGroup, "End Game", display.contentCenterX, 0, native.systemFont, 44)
   endButton:setFillColor(0.82, 0.86, 1)

   player = display.newImageRect(sceneGroup, "scene/game/img/player.png", 64, 64)
   player.x = display.contentCenterX
   player.y = display.contentCenterY

   endButton:addEventListener("tap", endGame)
   player:addEventListener("touch", dragPlayer)
end

-- show()
function scene:show(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase == "will") then
      -- Code here runs when the scene is still off screen (but is about to come on screen)
   elseif (phase == "did") then
   -- Code here runs when the scene is entirely on screen
   end
end

-- hide()
function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase == "will") then
      -- Code here runs when the scene is on screen (but is about to go off screen)
   elseif (phase == "did") then
   -- Code here runs immediately after the scene goes entirely off screen
   end
end

-- destroy()
function scene:destroy(event)
   local sceneGroup = self.view
   -- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene
