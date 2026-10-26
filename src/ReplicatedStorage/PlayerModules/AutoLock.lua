local AutoLock = {} 

function AutoLock.LockOn(target, camera, lerpNum)
	local targetCFrame = CFrame.new(camera.CFrame.Position, target.HumanoidRootPart.Position)
	camera.CFrame = camera.CFrame:Lerp(targetCFrame, lerpNum)
	
	return targetCFrame
end

function AutoLock.LockOnSnap(target, camera)
	camera.CFrame = CFrame.new(camera.CFrame.Position, target.HumanoidRootPart.Position)
end


return AutoLock

