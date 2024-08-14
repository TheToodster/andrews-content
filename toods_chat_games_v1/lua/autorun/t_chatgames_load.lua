--[[

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

	Support: discord.gg/YSzU6MY2Yb

	If you touch anything in this file and it breaks then ALL support is void.
	If you don't know what you're doing then don't touch it.

--]]

local blue = Color( 0, 150, 255 )
local white = Color( 255, 255, 255 )

T_CHATGAMES = T_CHATGAMES || {}
T_CHATGAMES.Config = T_CHATGAMES.Config || {}

local function AddFile( File, dir )
	local fileSide = string.lower( string.Left( File, 3 ) )
	if SERVER and fileSide == "sv_" then
		include( dir..File )
	elseif fileSide == "sh_" then
		if SERVER then 
			AddCSLuaFile( dir..File )
		end
		include( dir..File )
	elseif fileSide == "cl_" then
		if SERVER then 
			AddCSLuaFile( dir..File )
		else
			include( dir..File )
		end
	end
end

local function IncludeDir( dir )
	dir = dir .. "/"
	local File, Directory = file.Find( dir.."*", "LUA" )

	for k, v in ipairs( File ) do
		if string.EndsWith( v, ".lua" ) then
			AddFile( v, dir )
		end
	end
	
	for k, v in ipairs( Directory ) do
		IncludeDir( dir..v )
	end
end

IncludeDir( "chatgames_main" )

MsgC( blue, "\n[T-CHATGAMES] ", white, "Files Loaded!\n" )

if SERVER then

	util.AddNetworkString( "T_CHATGAMES.SendMessage" )

	function T_CHATGAMES:SendMessage( player, ... )
		net.Start( "T_CHATGAMES.SendMessage" )
			net.WriteTable( { ... } )
		net.Send( player )
	end

	function T_CHATGAMES:SendToAll( ... )
		net.Start( "T_CHATGAMES.SendMessage" )
			net.WriteTable( { ... } )
		net.Broadcast()
	end

elseif CLIENT then
	
	net.Receive( "T_CHATGAMES.SendMessage", function() 
		local info = net.ReadTable()
		chat.AddText( unpack( info ) )
		chat.PlaySound()
	end )

end