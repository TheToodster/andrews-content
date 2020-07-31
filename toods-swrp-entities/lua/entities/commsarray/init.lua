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
    self:SetModel( "models/props/starwars/tech/imperial_deflector_sky.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_NONE )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetHealth( self.CommHealth )
    self:SetMaxHealth( self.CommHealth )

    local CommPhys = self:GetPhysicsObject()
    if IsValid( CommPhys ) then
        CommPhys:Wake()
    end
end

local AllowComms = false
hook.Add( "PlayerSay", "DisableComms", function( ply, text, team )
    for k, v in pairs( ents.FindByClass( "commsarray" ) ) do
        if v:Health() > 0 then
            AllowComms = true
            break
        end
        if string.sub( text, 1, 6 ) == "/comms" || string.sub( text, 1, 7 ) == "/advert" || string.sub( text, 1, 3 ) == "/ad" || string.sub( text, 1, 4 ) == "/adv" then
            return ""
        end
        v:SetPlayerRepairing( true )
    end
end )

function ENT:OnTakeDamage( dmg )
    self:TakePhysicsDamage( dmg )
    if ( self:Health() <= 0 ) then return end
    self:SetHealth( math.Clamp( self:Health() - dmg:GetDamage(), 0, self:GetMaxHealth() ) )
    if self:Health() <= 0 then
    local BoomBoom3 = ents.Create( "env_explosion" )
        BoomBoom3:SetKeyValue( "spawnflags", 144 )
        BoomBoom3:SetKeyValue( "iMagnitude", 15 )
        BoomBoom3:SetKeyValue( "iRadiusOverride", 256 )
        BoomBoom3:SetPos( self:GetPos() )
        BoomBoom3:Spawn()
        BoomBoom3:Fire( "explode", "", 0 )
        PrintMessage( HUD_PRINTCENTER, "Communications Array has been destroyed!" )
        self:Ignite( 20, 250 )
        self:SetPlayerRepairing( false )
    end
end

function ENT:OnRemove()
    AllowComms = true
end
