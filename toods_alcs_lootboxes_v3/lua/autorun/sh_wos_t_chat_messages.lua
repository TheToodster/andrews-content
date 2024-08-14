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

-- Custom chat messages
T_WOS = T_WOS || {}

if SERVER then
	util.AddNetworkString( "T_WOS.SendMessage" )

	function T_WOS.SendMsg( player, ... )
		net.Start( "T_WOS.SendMessage" )
			net.WriteTable( { ... } )
		net.Send( player )
	end
elseif CLIENT then
	net.Receive( "T_WOS.SendMessage", function() 
		local data = net.ReadTable()
		chat.AddText( unpack( data ) )
		chat.PlaySound()
	end )
end