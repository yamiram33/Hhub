--// ALPLAXX HUB — RELEASE
--// Panel movible + optimización + tradeo simulado

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ALPLAXX_HUB"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- 🔑 Panel movible
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "✨ ALPLAXX HUB ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = MainFrame

-- Botón Optimización
local OptimizeButton = Instance.new("TextButton")
OptimizeButton.Size = UDim2.new(0.8, 0, 0, 40)
OptimizeButton.Position = UDim2.new(0.1, 0, 0.25, 0)
OptimizeButton.Text = "🚀 Optimizar Rendimiento"
OptimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
OptimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OptimizeButton.Font = Enum.Font.Gotham
OptimizeButton.TextScaled = true
OptimizeButton.Parent = MainFrame

OptimizeButton.MouseButton1Click:Connect(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end
    print("Rendimiento optimizado ✅")
end)

-- Botón Tradeo simulado
local TradeButton = Instance.new("TextButton")
TradeButton.Size = UDim2.new(0.8, 0, 0, 40)
TradeButton.Position = UDim2.new(0.1, 0, 0.45, 0)
TradeButton.Text = "🤝 Forzar Tradeo (Simulado)"
TradeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TradeButton.Font = Enum.Font.Gotham
TradeButton.TextScaled = true
TradeButton.Parent = MainFrame

TradeButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local closest = nil
    local shortestDist = math.huge

    for _, other in pairs(game.Players:GetPlayers()) do
        if other ~= player and other.Character and player.Character then
            local dist = (player.Character.PrimaryPart.Position - other.Character.PrimaryPart.Position).Magnitude
            if dist < shortestDist then
                shortestDist = dist
                closest = other
            end
        end
    end

    if closest then
        print("Solicitud de tradeo enviada a: "..closest.Name)
        -- Aquí deberías conectar con la función interna del juego que abre el tradeo
    else
        print("No hay jugadores cerca para tradear.")
    end
end)

-- Botón Updates
local UpdateButton = Instance.new("TextButton")
UpdateButton.Size = UDim2.new(0.8, 0, 0, 40)
UpdateButton.Position = UDim2.new(0.1, 0, 0.65, 0)
UpdateButton.Text = "🌐 Revisar Updates"
UpdateButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
UpdateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateButton.Font = Enum.Font.Gotham
UpdateButton.TextScaled = true
UpdateButton.Parent = MainFrame

UpdateButton.MouseButton1Click:Connect(function()
    print("Revisando actualizaciones 🌐")
end)
