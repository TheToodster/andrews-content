AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( T_LSCS.Config.LootboxModel )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetPos( self:GetPos() + Vector( 0, 0, 10 ) )

	local LootPhys = self:GetPhysicsObject()
	if !IsValid( LootPhys ) then return end
	LootPhys:Wake()
end

function ENT:Use( ply )
	if !IsValid( ply ) then return end
	if !ply:IsPlayer() then return end

	self.PlayerGotItem = self.PlayerGotItem || {}

	if self.PlayerGotItem[ply:SteamID()] then return end

	if !ply:GetNWBool( "T_LSCS.CanLoot." .. tostring( self:EntIndex() ) ) then
		T_LSCS.SendMsg( ply, Color( 0, 100, 255 ), "[T-LOOT] ", Color( 255, 255, 255 ), "You never dealt enough damage. You can't loot this lootbox!" )
		return
	end

	local item, rarity = T_LSCS.ChooseItem()
	ply:lscsAddInventory( item, false )

	T_LSCS.SendMsg( ply, Color( 0, 100, 255 ), "[T-LOOT] ", Color( 255, 255, 255 ), "You received a ", Color( 0, 185, 0 ), item, Color( 255, 255, 255 ), " from this lootbox!" )

	self.PlayerGotItem[ply:SteamID()] = true

	ply:SetNWBool( "T_LSCS.CanLoot." .. tostring( self:EntIndex() ), false )

	if self.Alreadyused then return end

	self.Alreadyused = true

	SafeRemoveEntityDelayed( self, T_LSCS.Config.LootboxDespawn )

end