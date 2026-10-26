local player = game:GetService("Players").LocalPlayer
local char = player.Character
local humanoid = char:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")


local WeaponLoadout = require(game.ReplicatedStorage.PlayerModules.WeaponLoadout)


local holdSword --Holding animation is here because it needs to be played as a track, and it allows it to be checked later to see if its playing when unequipped
local swordLunge --unfinished
local holdGun


local EquipEvent = game.ReplicatedStorage.Events:WaitForChild("EquipWeapon")


EquipEvent.OnClientEvent:Connect(function(weaponName)
	
	
	local meleeWeapon 
	local rangedWeapon
	
	if (holdSword and holdSword.IsPlaying) or not weaponName then --If hold sword is already playing or if there is no weapon passed in, then stop the animation and return
		holdSword:Stop()
		return
	end
	
	if (holdGun and holdGun.IsPlaying) or not weaponName then 
		holdGun:Stop()
		return
	end
	
	local equippedWeapon = WeaponLoadout:Equipped(player) --Checks what is currently equipped
	
	if equippedWeapon == "Ranged" then 
		print("RangedAnimation")
		
		rangedWeapon = char:FindFirstChild(weaponName)
		if not rangedWeapon then return end
		
		local animations = rangedWeapon:FindFirstChild("Animations")
		if not animations then return end
		
		if not holdGun then
			holdGun = animations:LoadAnimation(animations.GunIdleDemo) --Load the idle animation
		end
		
		holdGun:Play()

		
	else
		print("MeleeAnimation")
		
		meleeWeapon = char:FindFirstChild(weaponName)
		if not meleeWeapon then return end
		
		local animations = meleeWeapon:FindFirstChild("Animations")
		if not animations then return end

		if not holdSword then
			holdSword = animator:LoadAnimation(animations.SwordIdleDemo)
		end
		
		
		holdSword:Play()
	end
	

end)
