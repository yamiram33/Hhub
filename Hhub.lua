-- Script básico de ejemplo para Hhub.lua

-- Mensaje de bienvenida
print("Bienvenido a Hhub!")

-- Función simple
local function saludo(nombre)
    return "Hola, " .. nombre .. "! Gracias por usar Hhub."
end

-- Ejecutar la función con un ejemplo
print(saludo("Usuario"))

-- local player1Confirmed = false
local player2Confirmed = false

function confirmTrade(player)
    if player == player1 then
        player1Confirmed = true
    elseif player == player2 then
        player2Confirmed = true
    end

    if player1Confirmed and player2Confirmed then
        executeTrade()
    end
end

function executeTrade()
    print("Trade ejecutado correctamente")
    -- Aquí iría la lógica segura del intercambio
end
