--[[

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

	Support: discord.gg/YSzU6MY2Yb

--]]

-- How often, in minutes, do chat games start.
T_CHATGAMES.Config.GameCooldown = 30 -- 7 = 7 minutes, 20 = 20 minutes etc.

-- What usergroups can use the chat command to force a random chat game.
T_CHATGAMES.Config.StaffGroups = {
    ["superadmin"] = true,
    ["admin"] = true,
}

-- What command can the above usergroups type in chat to force a chat game.
-- Do not add ! or / as this is done in the code already.
T_CHATGAMES.Config.ForceGameCommand = "t_chatgame"

-- Define your chat games.
T_CHATGAMES.Config.ChatGames = {
    [1] = {
        GameQuestion = "Be the first to unscramble the following: omrrdgysa", -- This appears in chat for players to guess the answer.
        GameAnswer = "garrysmod", -- This is what the player needs to type into chat to get the reward. Keep this 1 word.
        GameTimer = 10, -- How long, in seconds, do players have to answer the question.
        RewardName = "+80 Jump Boost", -- Name of the reward, can be anything you like but must be unique.
        GiveReward = function( ply ) -- Function to define what happens when a player wins the game.
            ply:SetJumpPower( ply:GetJumpPower() + 80 )
        end,
    },
    [2] = {
        GameQuestion = "Solve the equation: (5 x 12) / 2",
        GameAnswer = "30",
        GameTimer = 10,
        RewardName = "+10 Health Boost",
        GiveReward = function( ply )
            ply:SetMaxHealth( ply:GetMaxHealth() + 10 )
            ply:SetHealth( math.Clamp( ply:Health() + 10, 0, ply:GetMaxHealth() ) )
        end,
    },
    [3] = {
        GameQuestion = "What comes once in a minute, twice in a moment, but never in a thousand years?",
        GameAnswer = "M",
        GameTimer = 10,
        RewardName = "Cash: $200",
        GiveReward = function( ply )
            if nut then -- Nutscript
                ply:getChar():giveMoney( 200 )
            elseif helix then -- Helix
                ply:GetCharacter():GiveMoney( 200 )
            elseif darkrp then -- DarkRP.
                ply:addMoney( 200 )
            end
        end,
    },
    [4] = {
        GameQuestion = "What has a head, a tail, is brown but has no legs?",
        GameAnswer = "A Penny",
        GameTimer = 10,
        RewardName = "Weapon: AR2",
        GiveReward = function( ply )
            if !ply:HasWeapon( "weapon_ar2" ) then
                ply:Give( "weapon_ar2" )
            else
                local wep = ply:GetWeapon( "weapon_ar2" )
                ply:GiveAmmo( 250, wep:GetPrimaryAmmoType() )
            end
        end,
    },
    [5] = {
        GameQuestion = "What is the square root of 144?",
        GameAnswer = "12",
        GameTimer = 10,
        RewardName = "+50 Armor Boost",
        GiveReward = function( ply )
            ply:SetArmor( ply:Armor() + 50 )
        end,
    },
    [6] = {
        GameQuestion = "What year was Garry's Mod first released?",
        GameAnswer = "2004",
        GameTimer = 10,
        RewardName = "Weapon: Shotgun",
        GiveReward = function( ply )
            if !ply:HasWeapon( "weapon_shotgun" ) then
                ply:Give( "weapon_shotgun" )
            else
                local wep = ply:GetWeapon( "weapon_shotgun" )
                ply:GiveAmmo( 50, wep:GetPrimaryAmmoType() )
            end
        end,
    },
    [7] = {
        GameQuestion = "What word in the entire dictionary is spelled incorrectly?",
        GameAnswer = "Incorrectly",
        GameTimer = 10,
        RewardName = "+60 Speed Boost",
        GiveReward = function( ply )
            ply:SetRunSpeed( ply:GetRunSpeed() + 60 )
        end
    },
    [8] = {
        GameQuestion = "What color do you get if you mix blue and red?",
        GameAnswer = "Purple",
        GameTimer = 10,
        RewardName = "+15 Health & +10 Armor Boost",
        GiveReward = function( ply )
            ply:SetMaxHealth( ply:GetMaxHealth() + 15 )
            ply:SetHealth( math.Clamp( ply:Health() + 15, 0, ply:GetMaxHealth() ) )
            ply:SetArmor( ply:Armor() + 10 )
        end,
    },
    [9] = {
        GameQuestion = "How many months of the year, in total, have 28 days?",
        GameAnswer = "12",
        GameTimer = 10,
        RewardName = "Weapon: Crossbow",
        GiveReward = function( ply )
            if !ply:HasWeapon( "weapon_crossbow" ) then
                ply:Give( "weapon_crossbow" )
            else
                local wep = ply:GetWeapon( "weapon_crossbow" )
                ply:GiveAmmo( 50, wep:GetPrimaryAmmoType() )
            end
        end,
    },
    [10] = {
        GameQuestion = "What is orange and sounds like a parrot?",
        GameAnswer = "A Carrot",
        GameTimer = 10,
        RewardName = "+50 Jump & +40 Speed Boost",
        GiveReward = function( ply )
            ply:SetJumpPower( ply:GetJumpPower() + 50 )
            ply:SetRunSpeed( ply:GetRunSpeed() + 40 )
        end,
    },
}