-- Creamos el ScreenGui
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)

-- Panel principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 250)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true -- Esto hace que el panel sea movible

-- Botón de correr
local runButton = Instance.new("TextButton", frame)
runButton.Size = UDim2.new(1, -10, 0, 40)
runButton.Position = UDim2.new(0, 5, 0, 10)
runButton.Text = "Correr"
runButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)

-- Botón de saltar
local jumpButton = Instance.new("TextButton", frame)
jumpButton.Size = UDim2.new(1, -10, 0, 40)
jumpButton.Position = UDim2.new(0, 5, 0, 60)
jumpButton.Text = "Saltar"
jumpButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)

-- Botón de volar
local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(1, -10, 0, 40)
flyButton.Position = UDim2.new(0, 5, 0, 110)
flyButton.Text = "Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)

-- Slider para modificar valores (ejemplo velocidad)
local speedBox = Instance.new("TextBox", frame)
speedBox.Size = UDim2.new(1, -10, 0, 40)
speedBox.Position = UDim2.new(0, 5, 0, 160)
speedBox.Text = "Velocidad: 16"
speedBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Script de funciones
local humanoid = player.Character:WaitForChild("Humanoid")

runButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = tonumber(speedBox.Text:match("%d+")) or 16
end)

jumpButton.MouseButton1Click:Connect(function()
    humanoid.JumpPower = 100 -- Puedes modificar este valor
end)

flyButton.MouseButton1Click:Connect(function()
    -- Ejemplo simple de fly
    local flying = true
    local bodyVelocity = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
    bodyVelocity.Velocity = Vector3.new(0,50,0)
    bodyVelocity.MaxForce = Vector3.new(4000,4000,4000)
    wait(3)
    bodyVelocity:Destroy()
end)
