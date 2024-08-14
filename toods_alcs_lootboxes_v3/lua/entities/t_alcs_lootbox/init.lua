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

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( "shared.lua" )
 
function ENT:Initialize()
 
    self:SetModel( T_WOS.Config.LootboxModel )
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

		if !ply:GetNWBool( "T_WOS.CanLoot." .. tostring( self:EntIndex() ) ) then
			T_WOS.SendMsg( ply, Color( 0, 100, 255 ), "[T-LOOT] ", Color( 255, 255, 255 ), "You never dealt enough damage to the NPC, you can't loot the lootbox!" )
			return
		end
	
		local item, rarity = T_WOS.ChooseItem()

		wOS:HandleItemPickup( ply, item )
		
		if T_WOS.Config.GiveXP != false && T_WOS.Config.GiveXP > 0 then
			ply:AddSkillXP( T_WOS.Config.GiveXP )
		end

		T_WOS.SendMsg( ply, Color( 0, 100, 255 ), "[T-LOOT] ", Color( 255, 255, 255 ), "You gained a ", Color( 0, 195, 0 ), item, Color( 255, 255, 255 ), " from this lootbox!" )
		
		self.PlayerHasUsed[ ply:SteamID() ] = true

		ply:SetNWBool( "T_WOS.CanLoot." .. tostring( self:EntIndex() ), false )
		
		if self.AlreadyUsed then return end
		
		self.AlreadyUsed = true
	
	end

end