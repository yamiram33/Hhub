local player1Confirmed = false
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
