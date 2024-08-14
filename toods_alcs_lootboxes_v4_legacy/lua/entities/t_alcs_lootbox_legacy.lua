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

AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel( self.Model )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetCollisionGroup( COLLISION_GROUP_WORLD )
        self:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
        
        local phys = self:GetPhysicsObject()
        if !IsValid( phys ) then return end
        phys:Wake()
    end

    function ENT:Use( ply )
        if !IsValid( ply ) then return end
        
        self.PlayerHasUsed = self.PlayerHasUsed or {}
        
        if self.PlayerHasUsed[ ply:SteamID64() ] then return end
        
        local NPCDrop = self:GetNWBool( "T_WOSLEGACY.NPCDrop" )
        local CanLoot = ply:GetNWBool( "T_WOSLEGACY.CanLoot." .. tostring( self:EntIndex() ) )
        
        if NPCDrop && !CanLoot then
            T_WOSLEGACY.SendMsg( ply, Color( 0, 100, 255 ), "[T-LOOT] ", Color( 255, 255, 255 ), "You never dealt enough damage to the NPC, you can't loot the lootbox!" )
            return
        end

        local item, xp = T_WOSLEGACY.ChooseItem( self.PrintName )

        wOS:HandleItemPickup( ply, item )
        
        if xp != false && xp > 0 then
            ply:AddSkillXP( xp )
        end

        T_WOSLEGACY.SendMsg( ply, Color( 0, 100, 255 ), "[T-LOOT] ", Color( 255, 255, 255 ), "You gained a ", T_WOSLEGACY.Config.LootTable[self.PrintName].color, item, Color( 255, 255, 255 ), " from a ", T_WOSLEGACY.Config.LootTable[self.PrintName].color, self.PrintName, Color( 255, 255, 255 ), " lootbox!" )
        
        self.PlayerHasUsed[ ply:SteamID64() ] = true

        ply:SetNWBool( "T_WOSLEGACY.CanLoot." .. tostring( self:EntIndex() ), false )
        
        if self.AlreadyUsed then return end
        
        self.AlreadyUsed = true
        
        SafeRemoveEntityDelayed( self, T_WOSLEGACY.Config.LootboxDespawn )
    end
end

if CLIENT then
    surface.CreateFont( "BlahBlah2", {
        font = "a Absolute Empire",
        extended = false,
        size = 20,
        weight = 1000,
        shadow = true,
        outline = false
    } )
    
    function ENT:Draw()
    
        self:DrawModel()
    
        local EntPos = self:GetPos()
        local ang = self:GetAngles()
        ang:RotateAroundAxis( ang:Forward(), 90 )
        ang:RotateAroundAxis( ang:Up(), 90 )
        ang.y = LocalPlayer():EyeAngles().y - 90
        if LocalPlayer():GetPos():DistToSqr( self:GetPos() ) < 512 * 512 then
            cam.Start3D2D( EntPos + Vector( 0, 0, 10 ), Angle( 0, ang.y, 90 ), .15 )
                draw.DrawText( self.PrintName, "BlahBlah2", 0, - 245, T_WOSLEGACY.Config.LootTable[self.PrintName].color, TEXT_ALIGN_CENTER )
            cam.End3D2D()
        end
    end
end