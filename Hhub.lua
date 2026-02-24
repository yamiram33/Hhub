-- Hub Moderno con opciones de correr, volar y golpear
-- Script de ejemplo para Roblox Studio

-- Crear ScreenGui
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ModernHub"

-- Crear Frame principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Botón de Correr
local runButton = Instance.new("TextButton", frame)
runButton.Size = UDim2.new(1, 0, 0, 50)
runButton.Position = UDim2.new(0, 0, 0, 0)
runButton.Text = "Correr"
runButton.MouseButton1Click:Connect(function()
    player.Character.Humanoid.WalkSpeed = 50 -- velocidad aumentada
end)

-- Botón de Volar
local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(1, 0, 0, 50)
flyButton.Position = UDim2.new(0, 0, 0, 60)
flyButton.Text = "Volar"
flyButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0)
    end
end)

-- Botón de Golpear
local punchButton = Instance.new("TextButton", frame)
punchButton.Size = UDim2.new(1, 0, 0, 50)
punchButton.Position = UDim2.new(0, 0, 0, 120)
punchButton.Text = "Golpear"
punchButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:TakeDamage(10) -- ejemplo de daño
    end
end)
