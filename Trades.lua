--// ALPLAXX HUB — RELEASE
--// Panel movible + botón de tradeo seguro

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ALPLAXX_HUB"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- 🔑 Esto permite mover el panel libremente
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "✨ ALPLAXX HUB ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = MainFrame

-- Botón de Tradeo (simulado)
local TradeButton = Instance.new("TextButton")
TradeButton.Size = UDim2.new(0.8, 0, 0, 40)
TradeButton.Position = UDim2.new(0.1, 0, 0.3, 0)
TradeButton.Text = "🤝 Forzar Tradeo (Simulado)"
TradeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TradeButton.Font = Enum.Font.Gotham
TradeButton.TextScaled = true
TradeButton.Parent = MainFrame

TradeButton.MouseButton1Click:Connect(function()
    -- Aquí puedes poner la lógica de abrir el sistema de tradeo
    -- Ejemplo: enviar solicitud de tradeo al jugador más cercano
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
        -- Aquí deberías usar la función propia del juego para abrir el tradeo
        -- (esto depende de cómo esté programado el sistema de tradeos en Steal a Brainrot)
    else
        print("No hay jugadores cerca para tradear.")
    end
end)
