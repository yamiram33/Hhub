-- Script moderno para Roblox con panel de sliders
-- Colócalo en StarterPlayerScripts como LocalScript

-- Valores iniciales
local defaultSpeed = 16
local defaultJump = 50
local defaultFly = 0

-- Referencias
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Crear GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ControlPanel"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Función para crear sliders
local function createSlider(name, min, max, default, positionY, callback)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, positionY)
    label.Text = name .. ": " .. default
    label.TextColor3 = Color3.new(1,1,1)
    label.BackgroundTransparency = 1

    local slider = Instance.new("TextButton", frame)
    slider.Size = UDim2.new(1, -10, 0, 20)
    slider.Position = UDim2.new(0, 5, 0, positionY + 25)
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

-- Slider para vuelo
createSlider("Vuelo", 0, 100, defaultFly, 115, function(value)
    local hrp = character:WaitForChild("HumanoidRootPart")
    local bv = hrp:FindFirstChild("BodyVelocity")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = hrp
    end
    bv.Velocity = Vector3.new(0, value, 0)
end)

-- Reset al respawnear
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = defaultSpeed
    humanoid.JumpPower = defaultJump
end)
