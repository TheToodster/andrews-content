local blue = Color( 0, 150, 255 )
local white = Color( 255, 255, 255 )
local ChatGameActive = false
local GameWinner = "N/A"
local GameAnswerr = ""
local RewardNamee
local RewardFunc

-- Kinda messy.
local function DoChatGame()
    if !ChatGameActive then
        ChatGameActive = true
        local data, key
        repeat -- Do a thing to make sure the questions are truly random
            data, key = table.Random( T_CHATGAMES.Config.ChatGames )
        until data.GameQuestion != LastQ
        LastQ = data.GameQuestion
        T_CHATGAMES:SendToAll( blue, "[T-CHATGAMES] ", white, data.GameQuestion )
        GameAnswerr = data.GameAnswer
        RewardNamee = data.RewardName
        RewardFunc = data.GiveReward
        timer.Stop( "T_CHATGAMES.PermTimer" )
        -- I think timer.Stop() stops, rewinds and restarts the timer so use timer.Pause() just to be sure.
        timer.Pause( "T_CHATGAMES.PermTimer" )
        timer.Simple( data.GameTimer, function() 
            if GameWinner != "N/A" then
                GameWinner = "N/A"
                ChatGameActive = false
                GameAnswerr = nil
                RewardNamee = nil
                RewardFunc = nil
                timer.Start( "T_CHATGAMES.PermTimer" )
                return
            else
                T_CHATGAMES:SendToAll( blue, "[T-CHATGAMES] ", white, "No one got the answer correct. Answer: ", blue, data.GameAnswer )
            end
            GameWinner = "N/A"
            ChatGameActive = false
            GameAnswerr = nil
            RewardNamee = nil
            RewardFunc = nil
            timer.Start( "T_CHATGAMES.PermTimer" )
        end )
    end
end

hook.Add( "InitPostEntity", "T_CHATGAMES.StartTimer", function() 
    timer.Create( "T_CHATGAMES.PermTimer", T_CHATGAMES.Config.GameCooldown * 60, 0, function() 
        if !ChatGameActive then
            DoChatGame()
        end
    end )
end )

hook.Add( "PlayerSay", "T_CHATGAMES.CheckPlayerTxt", function( ply, txt ) 
    if ( ChatGameActive && string.lower( string.Trim( txt ) ) == string.lower( string.Trim( GameAnswerr ) ) ) then
        GameWinner = ply:Nick()
        T_CHATGAMES:SendToAll( blue, "[T-CHATGAMES] ", white, GameWinner, " got the answer ", blue, GameAnswerr, white, " and gained ", blue, RewardNamee )
        RewardFunc( ply )
        ChatGameActive = false
        GameAnswerr = nil
        RewardNamee = nil
        RewardFunc = nil
        timer.Start( "T_CHATGAMES.PermTimer" )
        return ""
    elseif string.lower( txt ) == "!" .. string.lower( T_CHATGAMES.Config.ForceGameCommand ) || string.lower( txt ) == "/" .. string.lower( T_CHATGAMES.Config.ForceGameCommand ) then
        if !T_CHATGAMES.Config.StaffGroups[ply:GetUserGroup()] then
            T_CHATGAMES:SendMessage( ply, blue, "[T-CHATGAMES] ", white, "You don't have access to this command!" )
            return ""
        end
        if ChatGameActive then
            T_CHATGAMES:SendMessage( ply, blue, "[T-CHATGAMES] ", white, "There is already an active chat game!" )
            return ""
        end
        DoChatGame()
        return ""
    end
end )