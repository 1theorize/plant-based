local vinesystem = {}

export type vineconfig = {
	MaxSegments: number,
	SegmentLength: number,
	GrowthRate: number,
	Color: Color3,
	StraightSegments: number,
	BranchAtSegment: number?,
	BranchCount: number?,
	Generation: number?,
}

local default_config: vineconfig = {
	MaxSegments = 25,
	SegmentLength = 1.2,
	GrowthRate = 0.035,
	Color = Color3.fromRGB(34, 134, 39),
	StraightSegments = 5,
	BranchAtSegment = 5,
	BranchCount = 2,
	Generation = 1,
}

function vinesystem.grow(startPos: Vector3, initialDirection: Vector3, customconfig: vineconfig?): ()
	local config = customconfig or default_config
	local currentPos = startPos
	local currentDirection = initialDirection.Unit
	local generation = config.Generation or 1

	local vinefolder = workspace:FindFirstChild("vinebunch")
	if not vinefolder then
		vinefolder = Instance.new("Folder")
		vinefolder.Name = "vinebunch"
		vinefolder.Parent = workspace
	end

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {vinefolder}

	task.spawn(function()
		for i = 1, config.MaxSegments do
			local randomOffset = Vector3.new(
				(math.random() - 0.5) * 0.6,
				(math.random() - 0.5) * 0.3,
				(math.random() - 0.5) * 0.6
			)
			local spreadDirection = (currentDirection + randomOffset).Unit

			local blending = math.clamp((i - config.StraightSegments) / 5, 0, 1)
			local blendDirection = initialDirection.Unit:Lerp(spreadDirection, blending).Unit

			local raycastresult = workspace:Raycast(currentPos, blendDirection * config.SegmentLength, raycastParams)

			local nextpos: Vector3
			local surfaceNormal = Vector3.yAxis

			if raycastresult then 
				nextpos = raycastresult.Position
				surfaceNormal = raycastresult.Normal
				currentDirection = (blendDirection - 2 * blendDirection:Dot(surfaceNormal) * surfaceNormal).Unit
			else
				nextpos = currentPos + (blendDirection * config.SegmentLength)
				currentDirection = blendDirection
			end

			local segment = Instance.new("Part")
			segment.Name = "vinepart"
			segment.Shape = Enum.PartType.Cylinder
			segment.Material = Enum.Material.SmoothPlastic
			segment.Color = config.Color
			segment.Anchored = true
			segment.CanCollide = false
			segment.Size = Vector3.new(config.SegmentLength, 0.35 / generation, 0.35 / generation)

			local middlepoint = (currentPos + nextpos) / 2
			segment.CFrame = CFrame.lookAt(middlepoint, nextpos) * CFrame.Angles(0, math.rad(90), 0)
			segment.Parent = vinefolder

			if config.BranchAtSegment and i == config.BranchAtSegment and generation < 3 then
				local branchCount = config.BranchCount or 2
				local angleStep = (math.pi * 2) / branchCount

				for b = 1, branchCount do
					local angle = (b * angleStep) + (math.random() * 0.2)
					local outwardDir = (CFrame.fromAxisAngle(Vector3.yAxis, angle) * CFrame.new(currentDirection)).Position.Unit
					
					local childConfig: vineconfig = {
						MaxSegments = config.MaxSegments,
						SegmentLength = config.SegmentLength * 0.9,
						GrowthRate = config.GrowthRate,
						Color = config.Color,
						StraightSegments = 3,
						BranchAtSegment = (generation == 2) and nil or 4,
						BranchCount = 4,
						Generation = generation + 1,
					}

					vinesystem.grow(nextpos, outwardDir, childConfig)
				end
			end

			currentPos = nextpos
			task.wait(config.GrowthRate)
		end
	end)
end

return vinesystem