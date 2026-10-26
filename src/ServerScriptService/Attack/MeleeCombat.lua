local MeleeCombatEvent = game.ReplicatedStorage.Events:WaitForChild("MeleeCombat")
local ClosestEnemy = require(game.ReplicatedStorage.CombatModules.ClosestEnemy)

function ClosestEnemyCheck(player)
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	
	local closestEnemy = ClosestEnemy.getClosestEnemy(player)
	if not closestEnemy or not closestEnemy:IsA("Model") then return end

	local enemyRoot = closestEnemy:FindFirstChild("HumanoidRootPart")
	if not enemyRoot then return end
	
	if (rootPart.Position - enemyRoot.Position).Magnitude > 20 then
		return false
	end
	
	return closestEnemy
end

MeleeCombatEvent.OnServerEvent:Connect(function(player, action)
	if action == "ClosestEnemy" then
		local closestEnemy = ClosestEnemyCheck(player)
		MeleeCombatEvent:FireClient(player, closestEnemy)
	end


end)
