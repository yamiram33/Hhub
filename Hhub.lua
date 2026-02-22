-- Script para Roblox con panel visible
-- Colócalo en StarterPlayerScripts como LocalScript

-- Valores iniciales
local defaultSpeed = 16
local defaultJump = 50

-- Referencias
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Crear GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "Hb"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true -- Panel movible

-- Función para crear sliders
local function createSlider(name, min, max, default, posY, callback)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, posY)
    label.Text = name .. ": " .. default
    label.TextColor3 = Color3.new(1,1,1)
    label.BackgroundTransparency = 1

    local slider = Instance.new("TextButton", frame)
    slider.Size = UDim2.new(1, -10, 0, 20)
    slider.Position = UDim2.new(0, 5, 0, posY + 25)
    slider.Text = tostring(default)
    slider.BackgroundColor3 = Color3.fromRGB(80, 80, 200)

    slider.MouseButton1Click:Connect(function()
        local newValue = tonumber(slider.Text)
        if newValue then
            newValue = math.clamp(newValue + 5, min, max)
            slider.Text = tostring(newValue)
            label.Text = name .. ": " .. newValue
            callback(newValue)
        end
    end)
end

-- Slider para velocidad
createSlider("Velocidad", 16, 100, defaultSpeed, 5, function(value)
    humanoid.WalkSpeed = value
end)

-- Slider para salto
createSlider("Salto", 50, 200, defaultJump, 60, function(value)
    humanoid.JumpPower = value
end)

-- Botón para activar/desactivar correr rápido
local runButton = Instance.new("TextButton", frame)
runButton.Size = UDim2.new(1, -10, 0, 30)
runButton.Position = UDim2.new(0, 5, 0, 120)
runButton.Text = "Toggle Sprint"
runButton.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
runButton.TextColor3 = Color3.new(1,1,1)

runButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = (humanoid.WalkSpeed == defaultSpeed) and 32 or defaultSpeed
end)

-- Botón para activar/desactivar salto alto
local jumpButton = Instance.new("TextButton", frame)
jumpButton.Size = UDim2.new(1, -10, 0, 30)
jumpButton.Position = UDim2.new(0, 5, 0, 160)
jumpButton.Text = "Toggle High Jump"
jumpButton.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
jumpButton.TextColor3 = Color3.new(1,1,1)

jumpButton.MouseButton1Click:Connect(function()
    humanoid.JumpPower = (humanoid.JumpPower == defaultJump) and 120 or defaultJump
end)

-- Reset al respawnear
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = defaultSpeed
    humanoid.JumpPower = defaultJump
end)
