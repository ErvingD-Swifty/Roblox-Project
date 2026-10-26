local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EquipEvent = ReplicatedStorage.Events:WaitForChild("EquipWeapon")
local WeaponLockEvent = ReplicatedStorage.Events.Bindables:WaitForChild("WeaponLockEvent")
local HitPlayerEvent = ReplicatedStorage.Events:WaitForChild("HitPlayer")
local MeleeCombatEvent = ReplicatedStorage.Events:WaitForChild("MeleeCombat")
local WeaponLoadout = require(ReplicatedStorage.PlayerModules.WeaponLoadout)
local weaponEquipped = false



UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	
	if gameProcessedEvent then return end
	
	if input.KeyCode == Enum.KeyCode.F then
		EquipEvent:FireServer()	
		weaponEquipped = not weaponEquipped
	end
	
	
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 and weaponEquipped then
		
		WeaponLockEvent:Fire()
		
	end
	
end)
