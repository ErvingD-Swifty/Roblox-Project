local WeaponLoadout = {}
	
	local ItemData = require(game.ReplicatedStorage.DataModules.ItemData) --For inventory stuff 
	local WeaponData = require(game.ReplicatedStorage.DataModules.WeaponData) -- For everything else like damage and stuff
	
	WeaponLoadout.inventories = {} -- Creates a list for each player inside the module script

function WeaponLoadout:CreateInventory(player)

	self.inventories[player] = {
		Melee = {
		Item = nil,
		Rarity = nil
},
		Ranged = {
		Item = nil,
		Rarity = nil
},
			
		EquippedWeapon = nil --This shows the weapon that is currently equipped, nil means nothing is equipped
}
end

function WeaponLoadout:AddItem(player, itemName) -- Adds a weapon to the loadout
		
	local itemInfo = ItemData[itemName] --Checks if data for that item exists
	if not itemInfo then return end
		
	local inv = self.inventories[player] --Checks if player has inventory
	if not inv then return end
		
	if itemInfo.Type == "Melee" and inv.Melee.Item == nil then 
		inv.Melee.Item = itemName
		inv.Melee.Rarity = itemInfo.Rarity
	end
		
	if itemInfo.Type == "Ranged" and inv.Ranged.Item == nil then
		inv.Ranged.Item = itemName
		inv.Ranged.Rarity = itemInfo.Rarity
	end

end

function WeaponLoadout:GetMeleeStats(player) --Returns array with weapon data
	local inv = self.inventories[player]
	if not inv then end
	
	local weaponName = inv.Melee.Item
	
	return WeaponData[weaponName]
end

function WeaponLoadout:GetRangedStats(player) --Returns array with weapon data
		
	local inv = self.inventories[player]

	if not inv then return end

	local weaponName = inv.Ranged.Item

	if not weaponName then end

	return WeaponData[weaponName]

end

function WeaponLoadout:Equip(player, weaponType) --Sets the equipped weapon to whatever is passed, nil means no weapon is equipped
		
	local inv = self.inventories[player]
	if not inv then return end
	
	if weaponType == "Melee" or weaponType == "Ranged"  or weaponType == nil then
			inv.EquippedWeapon = weaponType
	end
end
	
function WeaponLoadout:Equipped(player) -- Returns the weapon that is equipped
	local inv = self.inventories[player]
	if not inv then return end
	
	return inv.EquippedWeapon
end

return WeaponLoadout
