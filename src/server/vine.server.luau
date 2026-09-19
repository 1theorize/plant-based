local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vineModule = ReplicatedStorage:FindFirstChild("vinesystem", true)
-- because im lwk slow, this should actullay locate the module bro)
if not vineModule then
	error("Failed to find the vinesystem mod in RS.")
end

local vinesystem = require(vineModule :: ModuleScript)
task.wait(2)

local originPos = Vector3.new(0, 0, 0)
local upwardDir = Vector3.new(0, 1, 0)
vinesystem.grow(originPos, upwardDir, {
	MaxSegments = 20,
	SegmentLength = 1.3,
	GrowthRate = 0.03,
	Color = Color3.fromRGB(40, 140, 50),
	StraightSegments = 5,
	BranchAtSegment = 5,
	BranchCount = 2,
	Generation = 1,
})