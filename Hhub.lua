-- Script moderno para Roblox con opción de correr más rápido
-- Colócalo en StarterPlayerScripts como LocalScript

-- Configuración
local normalSpeed = 16      -- Velocidad estándar de Roblox
local sprintSpeed = 32      -- Velocidad al correr
local sprintKey = Enum.KeyCode.LeftShift -- Tecla para activar sprint

-- Referencias
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Función para alternar velocidad
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == sprintKey then
        humanoid.WalkSpeed = sprintSpeed
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == sprintKey then
        humanoid.WalkSpeed = normalSpeed
    end
end)

-- Asegurar que al respawnear se reinicie la velocidad
player.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = normalSpeed
end)
