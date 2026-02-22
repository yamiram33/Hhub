-- LocalScript para StarterPlayerScripts
-- UI futurista con control de correr, salto y trade seguro

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Crear GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "HbMarketplace"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Título futurista
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Hb Marketplace"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Botón Sprint
local sprintButton = Instance.new("TextButton", frame)
sprintButton.Size = UDim2.new(1, -20, 0, 40)
sprintButton.Position = UDim2.new(0, 10, 0, 50)
sprintButton.Text = "Toggle Sprint"
sprintButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
sprintButton.TextColor3 = Color3.new(1,1,1)

sprintButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = (humanoid.WalkSpeed == 16) and 32 or 16
end)

-- Botón Jump
local jumpButton = Instance.new("TextButton", frame)
jumpButton.Size = UDim2.new(1, -20, 0, 40)
jumpButton.Position = UDim2.new(0, 10, 0, 100)
jumpButton.Text = "Toggle High Jump"
jumpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 120)
jumpButton.TextColor3 = Color3.new(1,1,1)

jumpButton.MouseButton1Click:Connect(function()
    humanoid.JumpPower = (humanoid.JumpPower == 50) and 120 or 50
end)

-- Slider Velocidad (simulado con botón incremental)
local speedButton = Instance.new("TextButton", frame)
speedButton.Size = UDim2.new(1, -20, 0, 40)
speedButton.Position = UDim2.new(0, 10, 0, 150)
speedButton.Text = "Velocidad: 16"
speedButton.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
speedButton.TextColor3 = Color3.new(1,1,1)

speedButton.MouseButton1Click:Connect(function()
    local current = tonumber(speedButton.Text:match("%d+"))
    local newValue = math.clamp(current + 5, 16, 100)
    humanoid.WalkSpeed = newValue
    speedButton.Text = "Velocidad: " .. newValue
end)

-- Slider Salto
local jumpSlider = Instance.new("TextButton", frame)
jumpSlider.Size = UDim2.new(1, -20, 0, 40)
jumpSlider.Position = UDim2.new(0, 10, 0, 200)
jumpSlider.Text = "Salto: 50"
jumpSlider.BackgroundColor3 = Color3.fromRGB(200, 80, 120)
jumpSlider.TextColor3 = Color3.new(1,1,1)

jumpSlider.MouseButton1Click:Connect(function()
    local current = tonumber(jumpSlider.Text:match("%d+"))
    local newValue = math.clamp(current + 10, 50, 200)
    humanoid.JumpPower = newValue
    jumpSlider.Text = "Salto: " .. newValue
end)

-- Sistema de Trade Seguro
local tradeConfirmed = false
local friendConfirmed = false

-- Botón de autoconfirmación propia
local confirmButton = Instance.new("TextButton", frame)
confirmButton.Size = UDim2.new(1, -20, 0, 40)
confirmButton.Position = UDim2.new(0, 10, 0, 250)
confirmButton.Text = "Confirmar Trade"
confirmButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
confirmButton.TextColor3 = Color3.new(1,1,1)

confirmButton.MouseButton1Click:Connect(function()
    tradeConfirmed = true
    confirmButton.Text = "Confirmado ✔"
    -- Aquí puedes enviar un RemoteEvent al servidor para registrar la confirmación
end)

-- Botón para confirmar amigo (simulado)
local friendButton = Instance.new("TextButton", frame)
friendButton.Size = UDim2.new(1, -20, 0, 40)
friendButton.Position = UDim2.new(0, 10, 0, 300)
friendButton.Text = "Esperando amigo..."
friendButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
friendButton.TextColor3 = Color3.new(1,1,1)

friendButton.MouseButton1Click:Connect(function()
    friendConfirmed = true
    friendButton.Text = "Amigo ✔"
    -- Aquí también se enviaría al servidor
    if tradeConfirmed and friendConfirmed then
        print("Trade completado de forma segura")
        -- Lógica de trade final aquí
    end
end)
