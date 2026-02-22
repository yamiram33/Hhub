local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SpeedEvent = ReplicatedStorage:WaitForChild("SpeedEvent")

local NORMAL_SPEED = 16
local FAST_SPEED = 32

SpeedEvent.OnServerEvent:Connect(function(player, enable)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        
        if enable then
            character.Humanoid.WalkSpeed = FAST_SPEED
        else
            character.Humanoid.WalkSpeed = NORMAL_SPEED
        end
        
    end
end)

-- Resetear velocidad al reaparecer
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").WalkSpeed = NORMAL_SPEED
    end)
end)
