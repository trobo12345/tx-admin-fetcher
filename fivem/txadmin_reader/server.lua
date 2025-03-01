Roby = {}

-- Function to fetch playersDB data via HTTP
Roby.getPlayerPlayTime = function(source, callback)
    -- The tx-admin-fetcher endpoint
    local url = "http://127.0.0.1:3000/playersdb"

    -- HTTP request to the endpoint
    PerformHttpRequest(url, function(errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            -- Convert the response into JSON format
            local playersData = json.decode(resultData)
            local steamID = nil

            -- Retrieve the player's SteamID using GetPlayerIdentifiers
            for _, id in ipairs(GetPlayerIdentifiers(source)) do
                if string.find(id, "steam:") then
                    steamID = id
                    break
                end
            end

            if not steamID then
                print("Error: SteamID not found for player: " .. tostring(source))
                callback(nil)
                return
            end

            local playTime = nil
            -- Check if playersData contains a "players" array
            if playersData and playersData.players then
                for _, player in ipairs(playersData.players) do
                    if player.ids then
                        for _, id in ipairs(player.ids) do
                            if id == steamID then
                                playTime = player.playTime
                                break
                            end
                        end
                    end
                    if playTime then break end
                end
            end

            if playTime then
                callback(playTime)
            else
                print("Playtime not found for SteamID: " .. steamID)
                callback(nil)
            end
        else
            print("HTTP error: " .. tostring(errorCode))
            callback(nil)
        end
    end, "GET")
end

-- Register command that fetches play time and sends it to the player as a message
RegisterCommand("getplaytime", function(source, args, rawCommand)
    Roby.getPlayerPlayTime(source, function(playTime)
        if playTime then
            TriggerClientEvent("chatMessage", source, "SERVER", {255, 255, 255}, "Your playtime: " .. playTime .. " minutes")
        else
            TriggerClientEvent("chatMessage", source, "SERVER", {255, 0, 0}, "Failed to retrieve playtime.")
        end
    end)
end)
