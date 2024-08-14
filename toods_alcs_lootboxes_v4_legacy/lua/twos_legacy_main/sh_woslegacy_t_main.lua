--[[----------------------------------------------------------------------

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

	Support: discord.gg/YSzU6MY2Yb

	If you touch anything in this file and it breaks then ALL support is void.
	If you don't know what you're doing then don't touch it.

--]]----------------------------------------------------------------------

local LootTable = T_WOSLEGACY.Config.LootTable

for name, data in pairs( LootTable ) do 
    local ENT = {}
    ENT.Base = "t_alcs_lootbox_legacy"
    ENT.PrintName = name
    ENT.Category = "[T-LOOT]"
    ENT.Spawnable = true
    ENT.Model = data.model
    local new = string.lower( string.gsub( name, "[^%w]+", "_" ) )
    local class = "t_loot_" .. new
    scripted_ents.Register( ENT, class )
    print( "Successfully registered entity class: " .. class )
end

if SERVER then
	util.AddNetworkString( "T_WOSLEGACY.SendMessage" )

	function T_WOSLEGACY.SendMsg( player, ... )
		net.Start( "T_WOSLEGACY.SendMessage" )
			net.WriteTable( { ... } )
		net.Send( player )
	end
elseif CLIENT then
	net.Receive( "T_WOSLEGACY.SendMessage", function() 
		local data = net.ReadTable()
		chat.AddText( unpack( data ) )
		chat.PlaySound()
	end )
end