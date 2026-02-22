-- Script Local en StarterPlayerScripts
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
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
frame.Visible = false -- Oculto al inicio

-- Animación de entrada (fade + zoom)
local function showFrame()
    frame.Visible = true
    frame.Size = UDim2.new(0, 100, 0, 70)
    frame.BackgroundTransparency = 1

    TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 350),
        BackgroundTransparency = 0.1
    }):Play()
end

-- Animación de salida (fade out)
local function hideFrame()
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 100, 0, 70)
    }):Play()
    task.wait(0.5)
    frame.Visible = false
end

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

-- Pulso neón en botones
local function pulse(button)
    while true do
        TweenService:Create(button, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        }):Play()
        task.wait(1)
        TweenService:Create(button, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        }):Play()
        task.wait(1)
    end
end

-- Lanzar animación de pulso en paralelo
task.spawn(function() pulse(confirmButton) end)
task.spawn(function() pulse(cancelButton) end)

-- Conectar botones
confirmButton.MouseButton1Click:Connect(function()
    TradeConfirm:FireServer("Trade123")
    hideFrame()
end)

cancelButton.MouseButton1Click:Connect(function()
    hideFrame()
end)

-- Mostrar el frame al iniciar
showFrame()
