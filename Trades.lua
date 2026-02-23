-- Botón Admin Panel
local AdminButton = Instance.new("TextButton")
AdminButton.Size = UDim2.new(0.8, 0, 0, 40)
AdminButton.Position = UDim2.new(0.1, 0, 0.85, 0)
AdminButton.Text = "🛠️ Activar Admin Panel"
AdminButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AdminButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AdminButton.Font = Enum.Font.Gotham
AdminButton.TextScaled = true
AdminButton.Parent = MainFrame

AdminButton.MouseButton1Click:Connect(function()
    -- Crear un sub-panel de admin
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
            player.Character.Humanoid.WalkSpeed = 50 -- velocidad aumentada
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
            player.Character.Humanoid.JumpPower = 150 -- salto aumentado
            print("Super salto activado 🌀")
        end
    end)
end)
