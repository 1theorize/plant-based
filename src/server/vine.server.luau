local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- because im lwk slow, this should actullay locate the module bro)
local vineModule = ReplicatedStorage:FindFirstChild("vinesystem", true)

if not vineModule then 
        error("failed to complete vinesystem module")
    end

    local vinesystem = require(vineModule :: ModuleScript)

    task.wait(2)

    -- og vines
    local origiposition = Vector3.new(0, 5, 0)
    local updwardDirection = Vector3.new(0, 1, 0)
-- spawn the vine 
vinesystem.grow(origiposition, updwardDirection, {
    MaxSegments = 20
    SegmentLength = 1.3,
    GrowthRate = 0.3,
    Color = Color3.fromRGB(40, 119, 44),
    StraightSegments = 5,
    BranchAtSegment = 5,
    BranchCount = 2,
    Generation = 1,
})