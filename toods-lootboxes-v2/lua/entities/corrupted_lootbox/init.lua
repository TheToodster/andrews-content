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
 
function ENT:Use( ply )

    if IsValid( ply ) && ply:IsPlayer() then
	
		self.PlayerHasUsed = self.PlayerHasUsed or {}
	
		if self.PlayerHasUsed[ ply:SteamID() ] then return end
	
		local howrare = math.random( 1, 1000 )

		self:SetBodygroup( 1, 1 )

		local getitem = table.Random( Loot.RareCorrupted )
		local dirandxp = table.Random( Loot.RareCorruptedXP )
		if howrare >= 1 && howrare <= 150 then
        	wOS:HandleItemPickup( ply, getitem )
			ply:AddSkillXP( dirandxp )
			ply:PrintMessage( HUD_PRINTCENTER, "You found a " .. getitem .. " and gained " .. dirandxp .. "xp from this lootbox." )
		end
		
		local getitem2 = table.Random( Loot.CommonCorrupted )
		local randxp = table.Random( Loot.CommonCorruptedXP )
		if howrare >= 151 && howrare <= 1000 then
			wOS:HandleItemPickup( ply, getitem2 )
			ply:AddSkillXP( randxp )
			ply:PrintMessage( HUD_PRINTCENTER, "You found a " .. getitem2 .. " and gained " .. randxp .. "xp from this lootbox." )
		end
		
		self.PlayerHasUsed[ ply:SteamID() ] = true
		
		if self.AlreadyUsed then return end
		
		self.AlreadyUsed = true

		timer.Simple( Loot.RemoveLootbox - 1, function() 
			self:SetBodygroup( 1, 0 )
		end )
		
		SafeRemoveEntityDelayed( self, Loot.RemoveLootbox )
	
	end

end