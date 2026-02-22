-- Variables principales
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradeRemote = ReplicatedStorage:WaitForChild("TradeRemote")

-- Función para iniciar un trade
function initiateTrade(player1, player2)
    -- Mostrar GUI futurista a ambos jugadores
    local tradeGUI1 = player1.PlayerGui:WaitForChild("TradeGUI")
    local tradeGUI2 = player2.PlayerGui:WaitForChild("TradeGUI")
    
    tradeGUI1.Enabled = true
    tradeGUI2.Enabled = true

    -- Opciones de confirmación
    tradeGUI1.ConfirmButton.MouseButton1Click:Connect(function()
        tradeGUI1.ConfirmButton.Visible = false
        tradeGUI1.Status.Text = "Esperando confirmación del otro jugador..."
        checkTradeConfirmation(player1, player2)
    end)

    tradeGUI2.ConfirmButton.MouseButton1Click:Connect(function()
        tradeGUI2.ConfirmButton.Visible = false
        tradeGUI2.Status.Text = "Esperando confirmación del otro jugador..."
        checkTradeConfirmation(player1, player2)
    end)
end

-- Función que revisa confirmaciones
function checkTradeConfirmation(player1, player2)
    local gui1 = player1.PlayerGui.TradeGUI
    local gui2 = player2.PlayerGui.TradeGUI
    
    if gui1.ConfirmButton.Visible == false and gui2.ConfirmButton.Visible == false then
        -- Ambos jugadores confirmaron
        gui1.Status.Text = "Trade completado ✅"
        gui2.Status.Text = "Trade completado ✅"
        executeTrade(player1, player2)
    end
end

-- Función para ejecutar trade
function executeTrade(player1, player2)
    -- Intercambia ítems seleccionados (ejemplo simplificado)
    local item1 = player1.Backpack:FindFirstChild("BrainrotItem")
    local item2 = player2.Backpack:FindFirstChild("BrainrotItem")
    
    if item1 and item2 then
        item1.Parent = player2.Backpack
        item2.Parent = player1.Backpack
        -- Efectos visuales futuristas
        print("¡Trade exitoso con efecto holográfico!")
    end
end

-- Conexión de la función con RemoteEvent
TradeRemote.OnServerEvent:Connect(function(player, targetPlayer)
    initiateTrade(player, targetPlayer)
end)
