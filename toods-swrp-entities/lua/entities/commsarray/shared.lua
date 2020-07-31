ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Author = "Tood."

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.PrintName = "Communications Array"
ENT.Category = "Tood's SWRP Entities"

ENT.CommHealth = 1500

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "PlayerRepairing" )
end
