-- // Servicios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Gui = Instance.new("ScreenGui")
Gui.Name = "StealABrainrot_ChilliHub"
Gui.Parent = Player.PlayerGui
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- // Paleta de Colores Moderna
local Colors = {
    Background = Color3.fromRGB(22, 22, 26),
    SidebarBg = Color3.fromRGB(30, 30, 35),
    CardBg = Color3.fromRGB(38, 38, 45),
    Primary = Color3.fromRGB(255, 85, 85), -- Acento rojizo como en la imagen
    PrimaryActive = Color3.fromRGB(255, 110, 110),
    Secondary = Color3.fromRGB(50, 50, 60),
    Text = Color3.fromRGB(240, 240, 245),
    TextDim = Color3.fromRGB(150, 150, 160),
    ToggleOff = Color3.fromRGB(60, 60, 70),
    ToggleOn = Color3.fromRGB(80, 250, 123) -- Verde brillante para estado activo
}

-- // Funciones de Modificación (Adaptadas al juego)
local ModFunctions = {
    -- Pestaña Player
    AntiRagdoll = {
        Enabled = false,
        Set = function(enabled)
            ModFunctions.AntiRagdoll.Enabled = enabled
            -- Lógica Anti-Ragdoll aquí
        end
    },
    SpeedBoost = {
        Enabled = false,
        Value = 3, -- Multiplicador (requiere 3 rebirths como en la imagen)
        Set = function(enabled, value)
            ModFunctions.SpeedBoost.Enabled = enabled
            ModFunctions.SpeedBoost.Value = value or ModFunctions.SpeedBoost.Value
            -- Lógica Speed Boost aquí (Q como tecla de activación)
        end
    },
    InfinityJump = {
        Enabled = false,
        Set = function(enabled)
            ModFunctions.InfinityJump.Enabled = enabled
            -- Lógica Salto Infinito aquí
        end
    },
    ChilliBooster = {
        Enabled = false,
        Value = 50,
        Set = function(enabled, value)
            ModFunctions.ChilliBooster.Enabled = enabled
            ModFunctions.ChilliBooster.Value = value or ModFunctions.ChilliBooster.Value
            -- Lógica Chilli Booster aquí
        end
    },
    -- Pestaña Stealer
    AutoSteal = {
        Enabled = false,
        Delay = 2, -- Segundos entre intentos
        Set = function(enabled, delay)
            ModFunctions.AutoSteal.Enabled = enabled
            ModFunctions.AutoSteal.Delay = delay or ModFunctions.AutoSteal.Delay
        end
    },
    -- Pestaña Helper
    AutoFarm = {
        Enabled = false,
        Area = "FishZone",
        Set = function(enabled, area)
            ModFunctions.AutoFarm.Enabled = enabled
            ModFunctions.AutoFarm.Area = area or ModFunctions.AutoFarm.Area
        end
    }
}

-- // Crear Contenedor Principal
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 700, 0, 550)
MainContainer.Position = UDim2.new(0.5, -350, 0.5, -275)
MainContainer.BackgroundColor3 = Colors.Background
MainContainer.BorderSizePixel = 0
MainContainer.CornerRadius = UDim.new(0, 12)
MainContainer.ClipsDescendants = true
MainContainer.Parent = Gui

-- // Sombra del Contenedor
local ContainerShadow = Instance.new("ImageLabel")
ContainerShadow.Name = "Shadow"
ContainerShadow.Size = UDim2.new(1, 30, 1, 30)
ContainerShadow.Position = UDim2.new(0, -15, 0, -15)
ContainerShadow.BackgroundTransparency = 1
ContainerShadow.Image = "rbxassetid://1316045217"
ContainerShadow.ImageColor3 = Color3.new(0, 0, 0)
ContainerShadow.ImageTransparency = 0.4
ContainerShadow.ZIndex = 0
ContainerShadow.Parent = MainContainer

-- // Barra Superior (Título)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Colors.SidebarBg
TopBar.BorderSizePixel = 0
TopBar.Parent = MainContainer

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "STEAL A BRAINROT - CHILLI HUB"
TitleLabel.TextColor3 = Colors.Text
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Colors.Secondary
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.CornerRadius = UDim.new(0, 8)
CloseBtn.Parent = TopBar

CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- // Panel Lateral (Navegación)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Colors.SidebarBg
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainContainer

-- // Función para Crear Botones de Navegación
local ActiveTab = "Main"
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -180, 1, -45)
ContentArea.Position = UDim2.new(0, 180, 0, 45)
ContentArea.BackgroundColor3 = Colors.Background
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 6
ContentArea.CanvasSize = UDim2.new(1, 0, 2, 0)
ContentArea.Parent = MainContainer

local function CreateNavButton(name, displayName)
    local Button = Instance.new("TextButton")
    Button.Name = name.."Btn"
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Position = UDim2.new(0, 0, 0, (40 * (#Sidebar:GetChildren()-1)))
    Button.BackgroundColor3 = (ActiveTab == name) and Colors.Primary or Colors.SidebarBg
    Button.Text = displayName
    Button.TextColor3 = Colors.Text
    Button.TextSize = 14
    Button.Font = Enum.Font.Gotham
    Button.BorderSizePixel = 0
    Button.Parent = Sidebar

    Button.MouseButton1Click:Connect(function()
        ActiveTab = name
        -- Actualizar colores de botones
        for _, btn in ipairs(Sidebar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = (btn.Name == name.."Btn") and Colors.Primary or Colors.SidebarBg
            end
        end
        -- Cargar contenido de la pestaña
        LoadTabContent(name)
    end)

    -- Efecto Hover
    Button.MouseEnter:Connect(function()
        if Button.BackgroundColor3 ~= Colors.Primary then
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        end
    end)
    Button.MouseLeave:Connect(function()
        if Button.BackgroundColor3 ~= Colors.Primary then
            Button.BackgroundColor3 = Colors.SidebarBg
        end
    end)
end

-- // Crear Botones de Navegación
CreateNavButton("Main", "Main (Fish)")
CreateNavButton("Stealer", "Stealer")
CreateNavButton("Helper", "Helper")
CreateNavButton("Player", "Player")
CreateNavButton("Finder", "Finder")
CreateNavButton("Server", "Server")
CreateNavButton("Discord", "Discord")

-- // Función para Crear Tarjetas de Opciones
local function CreateCard(parent, title)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(0.95, 0, 0, 120)
    Card.Position = UDim2.new(0.025, 0, 0, (#parent:GetChildren()-1)*130)
    Card.BackgroundColor3 = Colors.CardBg
    Card.BorderSizePixel = 0
    Card.CornerRadius = UDim.new(0, 8)
    Card.Parent = parent

    local CardTitle = Instance.new("TextLabel")
    CardTitle.Size = UDim2.new(1, 0, 0, 30)
    CardTitle.BackgroundTransparency = 1
    CardTitle.Text = title
    CardTitle.TextColor3 = Colors.Text
    CardTitle.TextSize = 15
    CardTitle.TextXAlignment = Enum.TextXAlignment.Left
    CardTitle.Font = Enum.Font.GothamBold
    CardTitle.Position = UDim2.new(0, 15, 0, 10)
    CardTitle.Parent = Card

    return Card
end

-- // Función para Crear Toggle con Etiqueta
local function CreateToggle(card, name, displayName, desc, yPos, hasSlider, sliderMin, sliderMax, defaultVal)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -30, 0, 35)
    ToggleFrame.Position = UDim2.new(0, 15, 0, yPos)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = card

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.5, 0)
    Label.BackgroundTransparency = 1
    Label.Text = displayName
    Label.TextColor3 = Colors.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.Parent = ToggleFrame

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    DescLabel.Position = UDim2.new(0, 0, 0.5, 0)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = desc
    DescLabel.TextColor3 = Colors.TextDim
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Name = name.."Toggle"
    ToggleBtn.Size = UDim2.new(0, 45, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -50, 0.25, 0)
    ToggleBtn.BackgroundColor3 = ModFunctions[name].Enabled and Colors.ToggleOn or Colors.ToggleOff
    ToggleBtn.Text = ""
    ToggleBtn.CornerRadius = UDim.new(1, 0)
    ToggleBtn.Parent = ToggleFrame

    local ToggleKnob = Instance.new("Frame")
    ToggleKnob.Name = "Knob"
    ToggleKnob.Size = UDim2.new(0, 16, 0, 16)
    ToggleKnob.Position = UDim2.new(ModFunctions[name].Enabled and 1 or 0, ModFunctions[name].Enabled and -21 or 2, 0.5, -8)
    ToggleKnob.BackgroundColor3 = Colors.Text
    ToggleKnob.CornerRadius = UDim.new(1, 0)
    ToggleKnob.Parent = ToggleBtn

    -- Lógica del Toggle
    ToggleBtn.MouseButton1Click:Connect(function()
        local NewState = not ModFunctions[name].Enabled
        ModFunctions[name].Set(NewState, ModFunctions[name].Value or ModFunctions[name].Delay or nil)
        
        -- Actualizar visual
        ToggleBtn.BackgroundColor3 = NewState and Colors.ToggleOn or Colors.ToggleOff
        ToggleKnob:TweenPosition(
            UDim2.new(NewState and 1 or 0, NewState and -21 or 2, 0.5, -8),
            Enum.EasingDirection.InOut,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
    end)

    -- Slider si es necesario
    if hasSlider then
        local Slider = Instance.new("Frame")
        Slider.Size = UDim2.new(0.5, 0, 0, 25)
        Slider.Position = UDim2.new(0.25, 0, 1, 5)
        Slider.BackgroundTransparency = 1
        Slider.Parent = ToggleFrame

        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Size = UDim2.new(0.3, 0, 1, 0)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = "Valor: "..defaultVal
        SliderLabel.TextColor3 = Colors.TextDim
        SliderLabel.TextSize = 12
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.Parent = Slider

        local SliderBg = Instance.new("Frame")
        SliderBg.Size = UDim2.new(0.65, 0, 0, 4)
        SliderBg.Position = UDim2.new(0.35, 0, 0.5, -2)
        SliderBg.BackgroundColor3 = Colors.Secondary
        SliderBg.CornerRadius = UDim.new(1, 0)
        SliderBg.Parent = Slider

        local SliderFill = Instance.new("Frame")
        SliderFill.Size = UDim2.new((defaultVal - sliderMin)/(sliderMax - sliderMin), 0, 1, 0)
        SliderFill.BackgroundColor3 = Colors.Primary
        SliderFill.CornerRadius = UDim.new(1, 0)
        SliderFill.Parent = SliderBg

        local SliderKnob = Instance.new("Frame")
        SliderKnob.Size = UDim2.new(0, 12, 0, 12)
        SliderKnob.Position = UDim2.new((defaultVal - sliderMin)/(sliderMax - sliderMin), -6, 0.5, -6)
        SliderKnob.BackgroundColor3 = Colors.PrimaryActive
        SliderKnob.CornerRadius = UDim.new(1, 0)
        SliderKnob.ZIndex = 2
        SliderKnob.Parent = SliderBg

        -- Lógica del Slider
        local Dragging = false
        local function UpdateSlider(posX)
            local relX = posX - SliderBg.AbsolutePosition.X
            local percent = math.clamp(relX / SliderBg.AbsoluteSize.X, 0, 1)
            local value = math.round(sliderMin + percent * (sliderMax - sliderMin))
            
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderKnob.Position = UDim2.new(percent, -6, 0.5, -6)
            SliderLabel.Text = "Valor: "..value
            
            ModFunctions[name].Value = value
            if ModFunctions[name].Enabled then
                ModFunctions[name].Set(true, value)
            end
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
                UpdateSlider(UserInputService:GetMouseLocation
                        
