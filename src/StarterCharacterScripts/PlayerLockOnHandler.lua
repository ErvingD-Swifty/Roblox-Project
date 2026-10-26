local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local userInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local enemies = game.Workspace:WaitForChild("Enemies")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")

local WeaponLockEvent = Events.Bindables:WaitForChild("WeaponLockEvent")
local MeleeCombatEvent = Events:WaitForChild("MeleeCombat")

local autoLockScript = require(ReplicatedStorage.PlayerModules.AutoLock)
local WeaponLoadout = require(ReplicatedStorage.PlayerModules.WeaponLoadout)

local playerGui = player:WaitForChild("PlayerGui")
local autoLockIndicator = playerGui:WaitForChild("AutoLockIndicator")
local autoLockOn = autoLockIndicator:WaitForChild("On")
local autoLockOff = autoLockIndicator:WaitForChild("Off")

local shiftPressed = false -- Checks if the shift key was pressed
local weaponLock = false
local closestEnemy = nil -- has a closest enemy variable set so the renderstepped can use it
local shiftLockConnection = nil --The connection to the renderstepped event
local weaponLockConnection = nil

local function removeWeaponLock()
	if weaponLockConnection then
		weaponLockConnection:Disconnect()
		weaponLockConnection = nil
	end

	weaponLock = false
	print("weapon lock removed")
end

local function removeShiftLock()
	if shiftLockConnection then
		shiftLockConnection:Disconnect()
		shiftLockConnection = nil
	end
	print("Shift lock removed")
end

userInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- Checks when a button is clicked, the input is the key clicked, game processed event checks if the click was already handled through something
	if gameProcessedEvent then return end
	
	if input.KeyCode == Enum.KeyCode.LeftShift then
		
		shiftPressed = not shiftPressed -- Reverses the true-false value of the shiftPressed variable
		
		if shiftPressed then
			print("Shift pressed fired")
			MeleeCombatEvent:FireServer("ClosestEnemy")
		else
			removeShiftLock()
			closestEnemy = nil
			
			if autoLockOn.Visible == true then --gui gets handled
				autoLockOn.Visible = false
				autoLockOff.Visible = true
			end
			print("Shift pressed again, removed shift lock")

		end
	end
end)


WeaponLockEvent.Event:Connect(function()
	
	weaponLock = true
	MeleeCombatEvent:FireServer("ClosestEnemy")
	print("WeaponLock Fired")
end)


MeleeCombatEvent.OnClientEvent:Connect(function(enemy)
	
	closestEnemy = enemy
	
	if not closestEnemy then 
		removeWeaponLock()
		shiftPressed = false
		print("No enemy found")
		return
	end
	
	rootPart.CFrame = CFrame.new(rootPart.Position, closestEnemy.HumanoidRootPart.Position) 

	
	if shiftPressed then -- if the shift key was pressed, stop, otherwise, it will stay locked on
		removeShiftLock()
		print("new shift lock connection started")
		
		if autoLockOn.Visible == false then -- gui gets handled
			autoLockOff.Visible = false
			autoLockOn.Visible = true
		end
		
		shiftLockConnection = RunService.RenderStepped:Connect(function()
			if closestEnemy then
				autoLockScript.LockOn(closestEnemy, camera, 0.3)
			end
		end)
	end
		
	if weaponLock then
		removeWeaponLock()
		weaponLock = true
		print("New weapon lock connection started")
		weaponLockConnection = RunService.RenderStepped:Connect(function() -- Saves the renderstopped in a connection so it can be deactivated later
			local enemyCFrame = autoLockScript.LockOn(closestEnemy, camera, 0.4) -- Uses the lock on script to lock on the enemy, 0.25 is the lerp number, the higher it is the faster the camera moves
			-- Gets the angle of where the enemy is

			local dot = camera.CFrame.LookVector:Dot(enemyCFrame.LookVector) -- Dot takes the look vector of the CFrame, and dot gets a comparison between the two look vecors.
			-- 1 = exact, 0 = 90 degrees away, -1 = opposite direction

			if dot >= 0.998 then
				removeWeaponLock()
			end
		end)
	end
	
end)

