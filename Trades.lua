--// ALPLAXX HUB — RELEASE
--// Panel movible + optimización + tradeo simulado + admin panel

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ALPLAXX_HUB"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
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
OptimizeButton.Position = UDim2.new(0.1, 0, 0.2, 0)
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
TradeButton.Position = UDim2.new(0.1, 0, 0.4, 0)
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
UpdateButton.Position = UDim2.new(0.1, 0, 0.6, 0)
UpdateButton.Text = "🌐 Revisar Updates"
UpdateButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
UpdateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateButton.Font = Enum.Font.Gotham
UpdateButton.TextScaled = true
UpdateButton.Parent = MainFrame

UpdateButton.MouseButton1Click:Connect(function()
    print("Revisando actualizaciones 🌐")
end)

-- Botón Admin Panel
local AdminButton = Instance.new("TextButton")
AdminButton.Size = UDim2.new(0.8, 0, 0, 40)
AdminButton.Position = UDim2.new(0.1, 0, 0.8, 0)
AdminButton.Text = "🛠️ Activar Admin Panel"
AdminButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AdminButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AdminButton.Font = Enum.Font.Gotham
AdminButton.TextScaled = true
AdminButton.Parent = MainFrame

AdminButton.MouseButton1Click:Connect(function()
    local AdminFrame = Instance.new("Frame")
    AdminFrame.Size = UDim2.new(0, 300, 0, 200)
    AdminFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    AdminFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    AdminFrame.Active = true
    AdminFrame.Draggable = true
    AdminFrame.Parent = ScreenGui

    local SpeedButton = Instance.new("TextButton")
    SpeedButton.Size = UDim2.new(0.8, 0, 0, 40)
    SpeedButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    SpeedButton.Text = "⚡ Activar Velocidad"
    SpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedButton.Font = Enum.Font.Gotham
    SpeedButton.TextScaled = true
    SpeedButton.Parent = AdminFrame

    SpeedButton.MouseButton1Click:Connect(function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 50
            print("Velocidad activada ⚡")
        end
    end)

    local JumpButton = Instance.new("TextButton")
    JumpButton.Size = UDim2.new(0.8, 0, 0, 40)
    JumpButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    JumpButton.Text = "🌀 Activar Super Salto"
    JumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpButton.Font = Enum.Font.Gotham
    JumpButton.TextScaled = true
    JumpButton.Parent = AdminFrame

    JumpButton.MouseButton1Click:Connect(function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = 150
            print("Super salto activado 🌀")
        end
    end)
end)
