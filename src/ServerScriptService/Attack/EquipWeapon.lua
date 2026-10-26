local EquipEvent = game.ReplicatedStorage.Events:WaitForChild("EquipWeapon")
local WeaponLoadout = require(game.ReplicatedStorage.PlayerModules.WeaponLoadout)
local ReplicatedStorage = game:GetService("ReplicatedStorage")


--Had very repetetive code, so made this cloning thing a function
local function duplicateWeapon(weapon, weaponName, character, rightHand)
	
	local weaponClone = weapon:Clone()
	weaponClone.Parent = character
	local cloneHandle = weaponClone:FindFirstChild("Handle") --Doesn't need to be checked because it is checked earlier in the script

	local motor6D = Instance.new("Motor6D") --Clone the motor6d because the weapon needs one for the animation
	motor6D.Part0 = rightHand
	motor6D.Part1 = cloneHandle 
	motor6D.C0 = weapon.IdleGripC0.Value --Value is in the weapon model
	motor6D.C1 = weapon.IdleGripC1.Value --Value is in the weapon model
	motor6D.Name = weaponName .. " Motor6D"
	motor6D.Parent = rightHand
	
	return weaponClone
end

EquipEvent.OnServerEvent:Connect(function(player)
	
	if not WeaponLoadout.inventories[player] then return end --Checks if inv exists for player
	
	local equippedSlot = WeaponLoadout:Equipped(player) --Checks what is currently equipped
	
	local character = player.Character 
	if not character then return end

	local rightHand = character:FindFirstChild("RightHand")
	if not rightHand then return end
	
	if equippedSlot == "Melee" then
		
		local meleeStats = WeaponLoadout:GetMeleeStats(player) -- If there is no melee weapon data in loadout, then equip nil and send it to the animation script to cancel animation
		if not meleeStats then 
			WeaponLoadout:Equip(player, nil) 
			EquipEvent:FireClient(player, nil) 
			return 
		end
		
		local equippedWeapon = character:FindFirstChild(meleeStats.Name) --Destroy the old weapon and motor6d if there is one
		if equippedWeapon then
			equippedWeapon:Destroy()
		end
		local motor6D = rightHand:FindFirstChild(meleeStats.Name .. " Motor6D")
		if motor6D then
			motor6D:Destroy()
		end
		
		
		local weaponStats = WeaponLoadout:GetRangedStats(player) -- If there is no ranged weapon data in loadout, then equip nil and send it to the animation script to cancel animation
		if not weaponStats then 
			WeaponLoadout:Equip(player, nil) 
			EquipEvent:FireClient(player, nil)
			return 
		end 
		
		local weaponName = weaponStats.Name
		local weapon = ReplicatedStorage.Tools:FindFirstChild(weaponName) --Makes sure the weapon exists in the storage
		if not weapon then 
			WeaponLoadout:Equip(player, nil) 
			EquipEvent:FireClient(player, nil)
			return 
		end 

		local handle = weapon:FindFirstChild("Handle") --Makes sure the weapon has a handle
		if not weapon then 
			WeaponLoadout:Equip(player, nil) 
			EquipEvent:FireClient(player, nil)
			return 
		end 

		duplicateWeapon(weapon, weaponName, character, rightHand)
		
		WeaponLoadout:Equip(player, "Ranged")
		EquipEvent:FireClient(player, weaponName)
		
	elseif equippedSlot == "Ranged" then
		
			
		local rangedStats = WeaponLoadout:GetRangedStats(player)
		if not rangedStats then 
			WeaponLoadout:Equip(player, nil) 
			EquipEvent:FireClient(player, nil) 
			return 
		end
		
		local equippedWeapon = character:FindFirstChild(rangedStats.Name)
		if equippedWeapon then
			equippedWeapon:Destroy()
		end
		
		local motor6D = rightHand:FindFirstChild(rangedStats.Name .. " Motor6D")
		if motor6D then
			motor6D:Destroy()
		end
			
			
		
		local weaponStats = WeaponLoadout:GetMeleeStats(player)
		if not weaponStats then 
			WeaponLoadout:Equip(player, nil) 
			EquipEvent:FireClient(player, nil) 
			return 
		end
		
		local weaponName = weaponStats.Name
		local weapon = ReplicatedStorage.Tools:FindFirstChild(weaponName)
		if not weapon then return end
		
		local handle = weapon:FindFirstChild("Handle")
		if not handle then return end
		
		
		duplicateWeapon(weapon, weaponName, character, rightHand)
		
		WeaponLoadout:Equip(player, "Melee")
		EquipEvent:FireClient(player, weaponName)
		
	elseif equippedSlot == nil then
		
		local weaponStats
		
		local meleeStats = WeaponLoadout:GetMeleeStats(player)
		local rangedStats = WeaponLoadout:GetRangedStats(player)
		
		if meleeStats then --Runs even if they have both weapons
			weaponStats = meleeStats
		elseif rangedStats then
			weaponStats = rangedStats
		else
			print("Player has no weapons")
			return
		end
		
		local weaponName = weaponStats.Name
		local weapon = ReplicatedStorage.Tools:FindFirstChild(weaponName)
		if not weapon then return end

		local handle = weapon:FindFirstChild("Handle")
		if not handle then return end

		duplicateWeapon(weapon, weaponName, character, rightHand)
		
		WeaponLoadout:Equip(player, weaponStats.Type)
		EquipEvent:FireClient(player, weaponName)
	end 

	
end)
