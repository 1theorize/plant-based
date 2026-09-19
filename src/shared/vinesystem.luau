local vinesystem = {}

export type vineconfig = {
	MaxSegments: number,
	SegmentLength: number,
	GrowthRate: number,
	Color: Color3,
}

local default_config: vineconfig = {
	MaxSegments = 30,
	SegmentLength = 1.4,
	GrowthRate = 0.04,
	Color = Color3.fromRGB(34, 134, 39),
}

function vinesystem.grow(startPos: Vector3, initialDirection: Vector3, customconfig: vineconfig?): ()
	local config = customconfig or default_config
	local currentPos = startPos
	local currentdirection = initialDirection.Unit

	local vinefolder = Instance.new("Folder")
	vinefolder.Name = "vines" .. tostring(math.random(100, 999))
	vinefolder.Parent = workspace

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {vinefolder}

	task.spawn(function()
		for i = 1, config.MaxSegments do
			local searchDirection = (currentdirection + Vector3.new(
				(math.random() - 0.5) * 0.5,
				(math.random() - 0.5) * 0.5,
				(math.random() - 0.5) * 0.5
			)).Unit

			local raycastresult = workspace:Raycast(currentPos, searchDirection * config.SegmentLength, raycastParams)

			local nextpos: Vector3
			local surfaceNormal = Vector3.yAxis

			if raycastresult then 
				nextpos = raycastresult.Position
				surfaceNormal = raycastresult.Normal
				currentdirection = (searchDirection - 2 * searchDirection:Dot(surfaceNormal) * surfaceNormal).Unit
			else
				nextpos = currentPos + (searchDirection * config.SegmentLength)
				currentdirection = searchDirection
			end

			local segment = Instance.new("Part")
			segment.Name = "vinepart"
			segment.Shape = Enum.PartType.Cylinder
			segment.Material = Enum.Material.SmoothPlastic
			segment.Color = config.Color
			segment.Anchored = true
			segment.CanCollide = false
			segment.Size = Vector3.new(config.SegmentLength, 0.3, 0.3)

			local middlepoint = (currentPos + nextpos) / 2
			segment.CFrame = CFrame.lookAt(middlepoint, nextpos) * CFrame.Angles(0, math.rad(90), 0)
			segment.Parent = vinefolder

			currentPos = nextpos
			task.wait(config.GrowthRate)
		end
	end)
end

return vinesystem