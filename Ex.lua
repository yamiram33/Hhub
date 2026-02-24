-- // Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Gui = Instance.new("ScreenGui")
Gui.Name = "SteelABrainrotHub"
Gui.Parent = Player.PlayerGui

-- // Colores Futuristas
local Colors = {
    Primary = Color3.fromRGB(0, 183, 255),
    Secondary = Color3.fromRGB(0, 122, 255),
    Background = Color3.fromRGB(15, 15, 25),
    Accent = Color3.fromRGB(100, 255, 218),
    Text = Color3.fromRGB(255, 255, 255)
}

-- // Funciones de Modificación (Ejemplos - ajusta según el juego)
local ModFunctions = {
    Speed = {
        Default = 16,
        Current = 16,
        Set = function(value)
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = value
                ModFunctions.Speed.Current = value
            end
        end
    },
    Jump = {
        Default = 50,
        Current = 50,
        Set = function(value)
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.JumpPower = value
                ModFunctions.Jump.Current = value
            end
        end
    },
    Flight = {
        Enabled = false,
        Speed = 50,
        Set = function(enabled, speed)
            ModFunctions.Flight.Enabled = enabled
            ModFunctions.Flight.Speed = speed or ModFunctions.Flight.Speed
            -- Lógica de vuelo aquí (ejemplo básico)
        end
    },
    Invisibility = {
        Enabled = false,
        Set = function(enabled)
            ModFunctions.Invisibility.Enabled = enabled
            if Player.Character then
                for _, part in ipairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = enabled and 0.9 or 0
                    end
                end
            end
        end
    }
}

-- // Crear Panel Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainPanel"
MainFrame.Size = UDim2.new(0, 400, 0, 550)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = Gui

-- // Efecto de Gradiente
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.Primary),
    ColorSequenceKeypoint.new(1, Colors.Secondary)
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- // Sombra
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

-- // Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundColor3 = Colors.Background
Title.BackgroundTransparency = 0.5
Title.Text = "STEEL A BRAINROT - HUB"
Title.TextColor3 = Colors.Text
Title.TextScaled = true
Title.Font = Enum.Font.RobotoMono
Title.ZIndex = 2
Title.Parent = MainFrame

-- // Botón de Cerrar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.RobotoMono
CloseBtn.ZIndex = 2
CloseBtn.Parent = Title

CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- // Función para Crear Secciones
local function CreateSection(name, positionY)
    local Section = Instance.new("Frame")
    Section.Name = name.."Section"
    Section.Size = UDim2.new(0.9, 0, 0, 100)
    Section.Position = UDim2.new(0.05, 0, 0, positionY)
    Section.BackgroundColor3 = Colors.Background
    Section.BackgroundTransparency = 0.3
    Section.BorderSizePixel = 0
    Section.ZIndex = 2
    Section.Parent = MainFrame

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = "Title"
    SectionTitle.Size = UDim2.new(1, 0, 0, 30)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = name:upper()
    SectionTitle.TextColor3 = Colors.Accent
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.TextSize = 18
    SectionTitle.Font = Enum.Font.RobotoMono
    SectionTitle.ZIndex = 2
    SectionTitle.Parent = Section

    return Section
end

-- // Función para Crear Slider
local function CreateSlider(section, name, min, max, default, yPos)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 30)
    SliderFrame.Position = UDim2.new(0, 0, 0, yPos)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = section

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name..": "..default
    Label.TextColor3 = Colors.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 14
    Label.Font = Enum.Font.RobotoMono
    Label.Parent = SliderFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.5, 0, 0, 6)
    SliderBg.Position = UDim2.new(0.45, 0, 0.5, -3)
    SliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = SliderFrame

    local SliderKnob = Instance.new("Frame")
    SliderKnob.Size = UDim2.new(0, 16, 0, 16)
    SliderKnob.Position = UDim2.new((default - min)/(max - min), -8, 0.5, -8)
    SliderKnob.BackgroundColor3 = Colors.Primary
    SliderKnob.BorderSizePixel = 0
    SliderKnob.CornerRadius = UDim.new(1, 0)
    SliderKnob.ZIndex = 3
    SliderKnob.Parent = SliderBg

    -- // Lógica del Slider
    local Dragging = false

    local function UpdateSlider(input)
        local Pos = input.Position.X - SliderBg.AbsolutePosition.X
        local Percent = math.clamp(Pos / SliderBg.AbsoluteSize.X, 0, 1)
        local Value = math.round(min + Percent * (max - min))
        SliderKnob.Position = UDim2.new(Percent, -8, 0.5, -8)
        Label.Text = name..": "..Value
        return Value
    end

    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if Dragging then
            local Value = UpdateSlider(UserInputService:GetMouseLocation())
            ModFunctions[name].Set(Value)
        end
    end)

    -- // Valor Inicial
    ModFunctions[name].Set(default)
end

-- // Función para Crear Toggle con Slider Adicional
local function CreateToggleWithSlider(section, name, yPos)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 60)
    ToggleFrame.Position = UDim2.new(0, 0, 0, yPos)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = section

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 0.5, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name:upper()
    Label.TextColor3 = Colors.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 14
    Label.Font = Enum.Font.RobotoMono
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Position = UDim2.new(0.45, 0, 0, 5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Colors.Text
    ToggleBtn.TextSize = 12
    ToggleBtn.Font = Enum.Font.RobotoMono
    ToggleBtn.Parent = ToggleFrame

    local Slider = CreateSlider(ToggleFrame, name.."Speed", 10, 100, ModFunctions[name].Speed, 30)

    -- // Lógica del Toggle
    ToggleBtn.MouseButton1Click:Connect(function()
        local NewState = not ModFunctions[name].Enabled
        ModFunctions[name].Set(NewState, ModFunctions[name].Speed)
        ToggleBtn.BackgroundColor3 = NewState and Colors.Primary or Color3.fromRGB(50, 50, 65)
        ToggleBtn.Text = NewState and "ON" or "OFF"
    end)
end

-- // Función para Crear Toggle Simple
local function CreateToggle(section, name, yPos)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 0, 0, yPos)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = section

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name:upper()
    Label.TextColor3 = Colors.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 14
    Label.Font = Enum.Font.RobotoMono
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Position = UDim2.new(0.45, 0, 0, 5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Colors.Text
    ToggleBtn.TextSize = 12
    ToggleBtn.Font = Enum.Font.RobotoMono
    ToggleBtn.Parent = ToggleFrame

    -- // Lógica del Toggle
    ToggleBtn.MouseButton1Click:Connect(function()
        local NewState = not ModFunctions[name].Enabled
        ModFunctions[name].Set(NewState)
        ToggleBtn.BackgroundColor3 = NewState and Colors.Primary or Color3.fromRGB(50, 50, 65)
        ToggleBtn.Text = NewState and "ON" or "OFF"
    end)
end

-- // Crear Secciones y Controles
local SpeedSection = CreateSection("Velocidad", 70)
CreateSlider(SpeedSection, "Speed", 16, 100, 16, 35)

local JumpSection = CreateSection("Salto", 180)
CreateSlider(JumpSection, "Jump", 50, 200, 50, 35)

local FlightSection = CreateSection("Vuelo", 290)
CreateToggleWithSlider(FlightSection, "Flight", 35)

local InvisibilitySection = CreateSection("Invisibilidad", 400)
CreateToggle(InvisibilitySection, "Invisibility", 35)

-- // Efecto de Brillo al Pasar el Ratón
local function AddHoverEffect(frame, color)
    frame.MouseEnter:Connect(function()
        frame.BackgroundColor3 = color
    end)
    frame.MouseLeave:Connect(function()
        frame.BackgroundColor3 = frame.Name == "CloseBtn" and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 65)
    end)
end

AddHoverEffect(CloseBtn, Color3.fromRGB(255, 80, 80))
AddHoverEffect(ToggleBtn, Colors.Secondary) -- Aplicar a todos los toggles (ajusta si es necesario)
