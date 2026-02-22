-- Script Local en StarterPlayerScripts
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradeConfirm = ReplicatedStorage:WaitForChild("TradeConfirm")

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TradeHubUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Marco principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 350)
frame.Position = UDim2.new(0.5, -250, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Borde futurista con gradiente
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
}
gradient.Rotation = 90
gradient.Parent = frame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.15, 0)
title.BackgroundTransparency = 1
title.Text = "╔══════════════════════════════╗\n║         TRADE HUB            ║"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

-- Sección ofertas
local offers = Instance.new("TextLabel")
offers.Size = UDim2.new(1, 0, 0.15, 0)
offers.Position = UDim2.new(0, 0, 0.15, 0)
offers.BackgroundTransparency = 1
offers.Text = "╠══════════════════════════════╣\n║   TU OFERTA   |  SU OFERTA   ║"
offers.TextColor3 = Color3.fromRGB(200, 255, 255)
offers.Font = Enum.Font.GothamBold
offers.TextScaled = true
offers.Parent = frame

-- Ejemplo de slots de ítems
local myItem = Instance.new("TextLabel")
myItem.Size = UDim2.new(0.45, 0, 0.25, 0)
myItem.Position = UDim2.new(0.05, 0, 0.3, 0)
myItem.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
myItem.Text = "[Imagen]\nNombre\nRareza\nValor"
myItem.TextColor3 = Color3.fromRGB(255, 255, 255)
myItem.Font = Enum.Font.Gotham
myItem.TextScaled = true
myItem.Parent = frame

local otherItem = myItem:Clone()
otherItem.Position = UDim2.new(0.5, 0, 0.3, 0)
otherItem.Text = "[Imagen]\nNombre\nRareza\nValor"
otherItem.Parent = frame

-- Auto-confirmar
local autoConfirm = Instance.new("TextButton")
autoConfirm.Size = UDim2.new(0.9, 0, 0.1, 0)
autoConfirm.Position = UDim2.new(0.05, 0, 0.6, 0)
autoConfirm.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
autoConfirm.Text = "☑ Auto-Confirmar"
autoConfirm.TextColor3 = Color3.fromRGB(0, 0, 0)
autoConfirm.Font = Enum.Font.GothamBold
autoConfirm.TextScaled = true
autoConfirm.Parent = frame

-- Estado
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0.1, 0)
status.Position = UDim2.new(0, 0, 0.72, 0)
status.BackgroundTransparency = 1
status.Text = "Estado: Esperando..."
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

-- Botones Confirmar y Cancelar
local confirmButton = Instance.new("TextButton")
confirmButton.Size = UDim2.new(0.4, 0, 0.12, 0)
confirmButton.Position = UDim2.new(0.05, 0, 0.85, 0)
confirmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
confirmButton.Text = "[CONFIRMAR]"
confirmButton.TextColor3 = Color3.fromRGB(0, 0, 0)
confirmButton.Font = Enum.Font.GothamBold
confirmButton.TextScaled = true
confirmButton.Parent = frame

local cancelButton = confirmButton:Clone()
cancelButton.Position = UDim2.new(0.55, 0, 0.85, 0)
cancelButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
cancelButton.Text = "[CANCELAR]"
cancelButton.Parent = frame

-- Conectar botones
confirmButton.MouseButton1Click:Connect(function()
    TradeConfirm:FireServer("Trade123") -- ID real del trade
    status.Text = "Estado: Confirmado ✔"
end)

cancelButton.MouseButton1Click:Connect(function()
    status.Text = "Estado: Cancelado ✖"
    frame.Visible = false
end)
