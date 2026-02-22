-- Script avanzado para Roblox con panel Hb
-- Colócalo en StarterPlayerScripts como LocalScript

-- Configuración inicial
local defaultSpeed = 16
local defaultJump = 50
local defaultFly = 0

-- Referencias
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Crear GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "Hb"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 250)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true -- Permite mover el panel

-- Función para crear botones
local function createButton(text, posY, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, posY)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
    button.TextColor3 = Color3.new(1,1,1)
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Botón: Sprint
createButton("Toggle Sprint", 5, function()
    humanoid.WalkSpeed = (humanoid.WalkSpeed == defaultSpeed) and 32 or defaultSpeed
end)

-- Botón: High Jump
createButton("Toggle High Jump", 50, function()
    humanoid.JumpPower = (humanoid.JumpPower == defaultJump) and 120 or defaultJump
end)

-- Botón: Fly
createButton("Toggle Fly", 95, function()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local bv = hrp:FindFirstChild("BodyVelocity")
    if bv then
        bv:Destroy()
    else
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 50, 0)
        bv.Parent = hrp
    end
end)

-- Botón: Golpear (simulación de ataque)
createButton("Golpear", 140, function()
    local hrp = character:WaitForChild("HumanoidRootPart")
    for _, target in pairs(workspace:GetChildren()) do
        if target:IsA("Model") and target:FindFirstChild("Humanoid") and target ~= character then
            local distance = (target.PrimaryPart.Position - hrp.Position).Magnitude
            if distance < 10 then
                target.Humanoid:TakeDamage(10) -- daño simulado
            end
        end
    end
end)

-- Botón: Invisibilidad
createButton("Toggle Invisibilidad", 185, function()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = (part.Transparency == 0) and 1 or 0
        elseif part:IsA("Decal") then
            part.Transparency = (part.Transparency == 0) and 1 or 0
        end
    end
end)

-- Reset al respawnear
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = defaultSpeed
    humanoid.JumpPower = defaultJump
end)
