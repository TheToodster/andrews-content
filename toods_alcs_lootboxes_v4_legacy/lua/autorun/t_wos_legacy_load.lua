--[[----------------------------------------------------------------------

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

	If you touch anything in this file and it breaks then ALL support is void.
	If you don't know what you're doing then don't touch it.

--]]----------------------------------------------------------------------

T_WOSLEGACY = T_WOSLEGACY || {}
T_WOSLEGACY.Config = T_WOSLEGACY.Config || {}

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

function T_WOSLEGACY:IncludeDir( dir )
	dir = dir .. "/"
	local File, Directory = file.Find( dir.."*", "LUA" )

	for k, v in ipairs( File ) do
		if string.EndsWith( v, ".lua" ) then
			AddFile( v, dir )
		end
	end
	
	for k, v in ipairs( Directory ) do
		T_WOSLEGACY:IncludeDir( dir..v )
	end
end

T_WOSLEGACY:IncludeDir( "twos_legacy_main" )