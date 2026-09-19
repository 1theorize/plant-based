local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vinesystem = require(ReplicatedStorage:WaitForChild("vinesystem") :: ModuleScript)

task.wait(2)

-- spawn the vine 
vinesystem.grow(Vector3.new(0, 5, 0), Vector3.new(1, 0.2, 0))