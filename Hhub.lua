-- Hub moderno con sliders + toggles
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)

-- Panel principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 350)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true -- Panel movible

-- Función para crear toggles
local function createToggle(name, positionY, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, positionY)
    button.Text = name .. ": OFF"
    button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    button.TextColor3 = Color3.fromRGB(255,255,255)

    local active = false
    button.MouseButton1Click:Connect(function()
        active = not active
        button.Text = name .. (active and ": ON" or ": OFF")
        button.BackgroundColor3 = active and Color3.fromRGB(0,200,100) or Color3.fromRGB(80,80,80)
        callback(active)
    end)
end

-- Función para crear sliders
local function createSlider(name, positionY, defaultValue, minValue, maxValue, callback)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, positionY)
    label.Text = name .. ": " .. defaultValue
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1

    local slider = Instance.new("TextButton", frame)
    slider.Size = UDim2.new(1, -10, 0, 20)
    slider.Position = UDim2.new(0, 5, 0, positionY + 25)
    slider.BackgroundColor3 = Color3.fromRGB(70,70,70)
    slider.Text = ""

    local knob = Instance.new("Frame", slider)
    knob.Size = UDim2.new(0, 10, 1, 0)
    knob.Position = UDim2.new((defaultValue-minValue)/(maxValue-minValue), -5, 0, 0)
    knob.BackgroundColor3 = Color3.fromRGB(0,200,255)

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
            knob.Position = UDim2.new(relativeX, -5, 0, 0)
            local value = math.floor(minValue + (maxValue-minValue)*relativeX)
            label.Text = name .. ": " .. value
            callback(value)
        end
    end)
end

-- Referencia al humanoid
local humanoid = player.Character:WaitForChild("Humanoid")

-- Toggle de correr
createToggle("Correr", 10, function(active)
    if active then
        humanoid.WalkSpeed = 50
    else
        humanoid.WalkSpeed = 16
    end
end)

-- Slider de velocidad
createSlider("Velocidad", 50, 16, 10, 100, function(value)
    humanoid.WalkSpeed = value
end)

-- Toggle de salto
createToggle("Saltar", 120, function(active)
    humanoid.JumpPower = active and 120 or 50
end)

-- Slider de salto
createSlider("Salto", 160, 50, 50, 200, function(value)
    humanoid.JumpPower = value
end)

-- Toggle de fly
createToggle("Fly", 230, function(active)
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        if active then
            local bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(4000,4000,4000)
            bv.Velocity = Vector3.new(0,50,0)
        else
            if root:FindFirstChild("BodyVelocity") then
                root.BodyVelocity:Destroy()
            end
        end
    end
end)

-- Slider de fly power
createSlider("Fly Power", 270, 50, 0, 200, function(value)
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if root and root:FindFirstChild("BodyVelocity") then
        root.BodyVelocity.Velocity = Vector3.new(0,value,0)
    end
end)
