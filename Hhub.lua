-- Script moderno para Roblox con panel de control
-- Colócalo en StarterPlayerScripts como LocalScript

-- Configuración inicial
local normalSpeed = 16
local sprintSpeed = 32
local normalJump = 50
local flySpeed = 50

-- Referencias
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")

-- Crear GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ControlPanel"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Botón para correr rápido
local runButton = Instance.new("TextButton", frame)
runButton.Size = UDim2.new(1, -10, 0, 40)
runButton.Position = UDim2.new(0, 5, 0, 5)
runButton.Text = "Toggle Sprint"
runButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)

-- Botón para salto alto
local jumpButton = Instance.new("TextButton", frame)
jumpButton.Size = UDim2.new(1, -10, 0, 40)
jumpButton.Position = UDim2.new(0, 5, 0, 50)
jumpButton.Text = "Toggle High Jump"
jumpButton.BackgroundColor3 = Color3.fromRGB(80, 200, 80)

-- Botón para volar
local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(1, -10, 0, 40)
flyButton.Position = UDim2.new(0, 5, 0, 95)
flyButton.Text = "Toggle Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(200, 80, 80)

-- Funciones
local sprinting = false
local highJump = false
local flying = false

runButton.MouseButton1Click:Connect(function()
    sprinting = not sprinting
    humanoid.WalkSpeed = sprinting and sprintSpeed or normalSpeed
end)

jumpButton.MouseButton1Click:Connect(function()
    highJump = not highJump
    humanoid.JumpPower = highJump and 120 or normalJump
end)

flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
        bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
    else
        local bv = character:WaitForChild("HumanoidRootPart"):FindFirstChild("BodyVelocity")
        if bv then bv:Destroy() end
    end
end)

-- Resetear al respawnear
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = normalSpeed
    humanoid.JumpPower = normalJump
end)
