local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- because im lwk slow, this should actullay locate the module bro)
local vineModule = ReplicatedStorage:FindFirstChild("vinesystem", true)

if not vineModule then 
    warn("vinesystem isn't in the ReplicatedStorage, do better:")
        for _, child in ReplicatedStorage:GetChildren() do
            print(" -") .. child.Name .. " (" .. child.ClassName .. ")")
        end
        error("failed to complete vinesystem module")
    end

    local vinesystem = require(vineModule :: ModuleScript)

    task.wait(2)

-- spawn the vine 
vinesystem.grow(Vector3.new(0, 5, 0), Vector3.new(1, 0.2, 0))