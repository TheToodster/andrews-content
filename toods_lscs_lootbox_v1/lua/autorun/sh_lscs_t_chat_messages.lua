-- Custom chat messages

T_LSCS = T_LSCS || {}

if SERVER then
	util.AddNetworkString( "T_LSCS.SendMessage" )

	function T_LSCS.SendMsg( player, ... )
		net.Start( "T_LSCS.SendMessage" )
			net.WriteTable( { ... } )
		net.Send( player )
	end
elseif CLIENT then
	net.Receive( "T_LSCS.SendMessage", function() 
		local data = net.ReadTable()
		chat.AddText( unpack( data ) )
		chat.PlaySound()
	end )
end