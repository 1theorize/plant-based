local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vineModule = ReplicatedStorage:FindFirstChild("vinesystem", true)
if not vineModule then
	error("Failed to find vinesystem mod in RS.")
end

local vinesystem = require(vineModule :: ModuleScript)
task.wait(2)

local originposition = Vector3.new(0, 0, 0)
local upwardDir = Vector3.new(0, 1, 0)
vinesystem.grow(originposition, upwardDir, {
	MaxSegments = 20,
	SegmentLength = 1.3,
	GrowthRate = 0.03,
	Color = Color3.fromRGB(40, 140, 50),
	StraightSegments = 5,
	BranchAtSegment = 5,
	BranchCount = 2,
	Generation = 1,
})