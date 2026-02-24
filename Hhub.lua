-- Hub estilizado con toggles + sliders + extras
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)

-- Panel principal con estilo moderno
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.UICorner = Instance.new("UICorner", frame)
frame.UICorner.CornerRadius = UDim.new(0, 12)

-- Animación de aparición
frame.Position = UDim2.new(0.5, -150, 1, 0)
frame:TweenPosition(UDim2.new(0.1, 0, 0.1, 0), "Out", "Quad", 1, true)

-- Función para crear toggles estilizados
local function createToggle(name, positionY, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -20, 0, 35)
    button.Position = UDim2.new(0, 10, 0, positionY)
    button.Text = name .. ": OFF"
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)

    local active = false
    button.MouseButton1Click:Connect(function()
        active = not active
        button.Text = name .. (active and ": ON" or ": OFF")
        button.BackgroundColor3 = active and Color3.fromRGB(0,200,100) or Color3.fromRGB(60,60,60)
        callback(active)
    end)
end

-- Función para crear sliders estilizados
local function createSlider(name, positionY, defaultValue, minValue, maxValue, callback)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, positionY)
    label.Text = name .. ": " .. defaultValue
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14

    local slider = Instance.new("Frame", frame)
    slider.Size = UDim2.new(1, -20, 0, 20)
    slider.Position = UDim2.new(0, 10, 0, positionY + 25)
    slider.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local corner = Instance.new("UICorner", slider)
    corner.CornerRadius = UDim.new(0, 8)

    local knob = Instance.new("Frame", slider)
    knob.Size = UDim2.new(0, 12, 1, 0)
    knob.Position = UDim2.new((defaultValue-minValue)/(maxValue-minValue), -6, 0, 0)
    knob.BackgroundColor3 = Color3.fromRGB(0,200,255)
    local knobCorner = Instance.new("UICorner", knob)
    knobCorner.CornerRadius = UDim.new(1,0)

    local dragging = false
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = math.clamp((input.Position.X - slider.AbsolutePosition.X)/slider.AbsoluteSize.X, 0, 1)
            knob.Position = UDim2.new(relativeX, -6, 0, 0)
            local value = math.floor(minValue + (maxValue-minValue)*relativeX)
            label.Text = name .. ": " .. value
            callback(value)
        end
    end)
end

-- Referencia al humanoid
local humanoid = player.Character:WaitForChild("Humanoid")

-- Toggle Fly Estático
createToggle("Fly Estático", 10, function(active)
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        if active then
            local bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(4000,4000,4000)
            bv.Velocity = Vector3.new(0,0,0) -- Mantener estático
        else
            if root:FindFirstChild("BodyVelocity") then
                root.BodyVelocity:Destroy()
            end
        end
    end
end)

-- Toggle Quitar Animaciones
createToggle("Quitar Animaciones", 60, function(active)
    local animate = player.Character:FindFirstChild("Animate")
    if animate then
        animate.Disabled = active
    end
end)

-- Toggle Golpear
createToggle("Golpear", 110, function(active)
    if active then
        local tool = Instance.new("Tool", player.Backpack)
        tool.Name = "Punch"
        tool.RequiresHandle = false
        tool.Activated:Connect(function()
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _, target in pairs(game.Players:GetPlayers()) do
                    if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (target.Character.HumanoidRootPart.Position - root.Position).Magnitude
                        if dist < 5 then
                            target.Character.Humanoid:TakeDamage(10)
                            target.Character.HumanoidRootPart.Velocity = Vector3.new(0,50,0) -- Empuje hacia arriba
                        end
                    end
                end
            end
        end)
    else
        local punch = player.Backpack:FindFirstChild("Punch")
        if punch then punch:Destroy() end
    end
end)

-- Slider de Velocidad
createSlider("Velocidad", 160, 16, 10, 100, function(value)
    humanoid.WalkSpeed = value
end)

-- Slider de Salto
createSlider("Salto", 220, 50, 50, 200, function(value)
    humanoid.JumpPower = value
end)

-- Slider de Fly Power
createSlider("Fly Power", 280, 50, 0, 200, function(value)
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if root and root:FindFirstChild("BodyVelocity") then
        root.BodyVelocity.Velocity = Vector3.new(0,value,0)
    end
end)
