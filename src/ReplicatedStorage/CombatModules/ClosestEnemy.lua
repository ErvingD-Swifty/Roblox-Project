local ClosestEnemy = {}

local enemies = game.Workspace:WaitForChild("Enemies")

function ClosestEnemy.getClosestEnemy(player)
	local character = player.Character or player.CharacterAdded:Wait()
	if not character then return nil end
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	local closestEnemy = nil
	local closestDistance = nil
	for _, enemy in pairs(enemies:GetChildren()) do
		if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
			local distance = (enemy.HumanoidRootPart.Position - rootPart.Position).Magnitude
			if closestDistance == nil or distance < closestDistance then
				closestDistance = distance
				closestEnemy = enemy
			end
		end
	end
	return closestEnemy
end

return ClosestEnemy
