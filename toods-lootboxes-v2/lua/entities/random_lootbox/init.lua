--[[------------------------------------------------------------
    ____________										   ___
    |		   |   									 	  |	  |
    |___	___|	__________   	__________			  |	  |
    	|	|	   /		  \	   /		  \		   	  |	  |
    	|	|	  |			   |  |			   |	  ____|   |
    	|	|	  |			   |  |			   |	 / 		  |
    	|	|	  |			   |  |			   |	|		  |
    	|___|	   \__________/    \__________/		 \________|

    Author: Tood/The Toodster.
    Contact: Discord - The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/
--]]------------------------------------------------------------

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( "shared.lua" )
 
function ENT:Initialize()
 
    self:SetModel( "models/helios/sw/crate/full.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_NONE )
    self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetPos( self:GetPos() + Vector( 0, 0, 10 ) )
   
    local boxphys = self:GetPhysicsObject()
   
    if boxphys:IsValid() then
        boxphys:Wake()

    end
 
end

local entswos = {
	"crystal_lootbox",
	"hilt_lootbox",
	"staff_lootbox",
	"misc_lootbox"
}

local entswos2 = {
	"corrupted_lootbox",
	"unstable_lootbox",
	"darkinner_lootbox"
}

hook.Add( "OnNPCKilled", "ToodsHooksV1", function( npc, killer )
	if IsValid( killer ) && killer:IsPlayer() then
		if Loot.RandomNPCs[npc:GetClass()] then
			local isthisrare = math.random( 1, 1000 )
			
			local dropentity = table.Random( entswos2 )
			if isthisrare >= 1 && isthisrare <= 10 then
			local dropbox = ents.Create( dropentity )
				dropbox:SetPos( npc:LocalToWorld( Vector( 0, 80, 10 ) ) )
				dropbox:Spawn()
				dropbox:Activate()
			end
					
			local dropentity2 = table.Random( entswos )
			if isthisrare >= 11 && isthisrare <= 200 then
			local dropbox2 = ents.Create( dropentity2 )
				dropbox2:SetPos( npc:LocalToWorld( Vector( 0, 80, 10 ) ) )
				dropbox2:Spawn()
				dropbox2:Activate()
			end
				
			if isthisrare >= 201 && isthisrare <= 1000 then
				killer:PrintMessage( HUD_PRINTCENTER, "You never received a lootbox from this NPC, try again." )
			end
		end
	end
end )