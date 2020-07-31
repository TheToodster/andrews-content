--[[------------------------------------------------------------------------------
                                                                     dddddddd
TTTTTTTTTTTTTTTTTTTTTTT                                              d::::::d
T:::::::::::::::::::::T                                              d::::::d
T:::::TT:::::::TT:::::T                                              d:::::d 
TTTTTT  T:::::T  TTTTTT   ooooooooooo      ooooooooooo       ddddddddd:::::d 
        T:::::T        o:::::::::::::::oo:::::::::::::::o d::::::::::::::::d 
        T:::::T        o:::::ooooo:::::oo:::::ooooo:::::od:::::::ddddd:::::d 
        T:::::T        o::::o     o::::oo::::o     o::::od:::::d     d:::::d 
      TT:::::::TT      o:::::ooooo:::::oo:::::ooooo:::::od::::::ddddd::::::dd
      T:::::::::T       oo:::::::::::oo  oo:::::::::::oo   d:::::::::ddd::::d
      TTTTTTTTTTT         ooooooooooo      ooooooooooo      ddddddddd   ddddd

Version: 1.0
Contact: Discord - The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/

Disclaimer: If you mess with anything inside this file and you break it then it's on you. Do not come to me for support. 
If you don't know what you are doing then don't touch it.

--]]-------------------------------------------------------------------------------

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( "shared.lua" )

local NPCModel
local NPCWeapon
local NPCHealth
local NPCAmount

local MinSpawn
local MaxSpawn

function ENT:KeyValue( TKey, TValue )
    if TKey == "ModelNPC" then
        SwapNPCModel = tostring( TValue )
    end
    if TKey == "ModelPod" then
        self:SetModel( TValue )
    end
    if TKey == "WeaponNPC" then
        NPCWeapon = TValue
    end
    if TKey == "HealthNPC" then
        NPCHealth = TValue
    end
    if TKey == "MinSpawn" then
        MinSpawn = TValue
    end
    if TKey == "MaxSpawn" then
        MaxSpawn = TValue
    end
    if TKey == "HealthPod" then
        self:SetHealth( TValue )
		self:SetMaxHealth( TValue )
    end
    if TKey == "AmountNPC" then
        NPCAmount = TValue
    end
end

function ENT:Initialize()

    self:SetModel( self:GetModel() )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetHealth( self:Health() )
	self:SetMaxHealth( self:GetMaxHealth() )
    self:SetSolid( SOLID_VPHYSICS )
    self:DrawShadow( true )
    local phys = self:GetPhysicsObject()
 
    if ( phys:IsValid() ) then
        phys:Wake()
    end
 
    self.Collided = false
 
    timer.Simple( 2.6, function()
        self:EmitSound( "sanctum2/towers/tower_entry" .. math.random( 1, 2 ) .. ".ogg", 150, math.Rand( 80, 120 ) )
    end )
end

local ListNPCs = {
    "npc_citizen",
    "npc_alyx",
    "npc_barney",
    "npc_kleiner",
    "npc_mossman",
    "npc_eli",
    "npc_gman",
    "npc_breen",
    "npc_monk",
    "npc_combine_s",
    "npc_metropolice",
    "npc_zombine",
    "npc_poisonzombine"
    }
 
local spawnTable = { }
 
spawnTable[1] = { v = Vector(90, 90, 1) }
spawnTable[2] = { v = Vector(-90, 90, 1) }
spawnTable[3] = { v = Vector(-90, -90, 1) }
spawnTable[4] = { v = Vector(90, -90, 1) }
spawnTable[5] = { v = Vector(-45, 90, 1) }
spawnTable[6] = { v = Vector(59, 90, 1) }
spawnTable[7] = { v = Vector(73, 75, 1) }
spawnTable[8] = { v = Vector(34, -85, 1) }
spawnTable[9] = { v = Vector(-130, 85, 1) }
spawnTable[10] = { v = Vector(-177, -95, 1) }
spawnTable[11] = { v = Vector(90, 85, 1) }
spawnTable[12] = { v = Vector(90, -85, 1) }
spawnTable[13] = { v = Vector(120, 45, 1) }
spawnTable[14] = { v = Vector(155, 120, 1) }
spawnTable[15] = { v = Vector(-120, 45, 1) }
spawnTable[16] = { v = Vector(155, -120, 1) }
spawnTable[17] = { v = Vector(60, -140, 1) }
spawnTable[18] = { v = Vector(-60, 140, 1) }
spawnTable[19] = { v = Vector(-60, -140, 1) }
spawnTable[20] = { v = Vector(195, -70, 1) } 
-- If you change the NPC amount limit in dispenser_tool.lua then you need to add more vectors to match the limit of the NPC amount.
 
 
function ENT:PhysicsCollide( data, phys )
    if not IsValid( self ) then return end
    if not IsValid( self ) then return end
    local CheckLocAng = self:GetAngles()
 
    if not data.HitEntity:IsValid() then
        self:CollideEffect()
        self.Collided = true
 
        if ( math.abs( CheckLocAng.r ) < 45 ) then
            phys:EnableMotion( false )
            phys:Sleep()
        
            for i = 1, NPCAmount do
                timer.Simple( math.random( MinSpawn, MaxSpawn ), function()
                if IsValid( self ) then
                        local SpawnNpc = ents.Create( "npc_combine_s" )
                        SpawnNpc:SetPos( self:GetPos() + spawnTable[i].v )
                        SpawnNpc:SetModel( SwapNPCModel )
                        timer.Simple( 0.1, function() -- Well SetHealth() is being retarded and refuses to set the health when using SetHealth() on it's own so needed to add a timer...
                            SpawnNpc:SetHealth( NPCHealth )
                        end )
                        SpawnNpc:Give( NPCWeapon )
                        SpawnNpc:SetMoveType( MOVETYPE_STEP )
                        SpawnNpc:SetBloodColor( DONT_BLEED )
                        SpawnNpc:Spawn()
                        SpawnNpc:DropToFloor()
                    end
                end)
            end
        end
    elseif data.HitEntity:IsValid() then
        if table.HasValue( ListNPCs, string.lower( data.HitEntity:GetClass() ) ) or data.HitEntity:IsPlayer() then
            if not self.Collided then
                local CheckBoom = EffectData()
                CheckBoom:SetScale( 1.6 )
                CheckBoom:SetOrigin( data.HitEntity:GetPos() + Vector( 0, 0, -32 ) )
                util.Effect( "m9k_gdcw_s_blood_cloud", CheckBoom )
            end
        end
 
        if not data.HitEntity:IsPlayer() and ( math.abs( CheckLocAng.r ) < 15 ) then
            if data.HitEntity:GetClass() ~= "prop_vehicle_jeep" then
                if not self.Collided then
                    data.HitEntity:Remove()
                end
            end
        end
    end
end
 
function ENT:CollideEffect()
if self.Collided then return end
local CheckBoom2 = EffectData()
    CheckBoom2:SetOrigin( self:GetPos() + Vector( 0, 0, 0 ) )
    CheckBoom2:SetEntity( self )
    CheckBoom2:SetScale( 1.2 )
    CheckBoom2:SetMagnitude( 65 )
    util.Effect( "m9k_gdcw_s_boom", CheckBoom2 )
    util.BlastDamage( self, self, self:GetPos(), 102, 212 )
    util.ScreenShake( self:GetPos(), 16, 250, 1, 512 )
    self:EmitSound( "sanctum2/towers/tower_impact" .. math.random( 1, 3 ) .. ".ogg", 150, math.Rand( 80, 120 ) )
end

function ENT:OnTakeDamage( dmg )
    self:TakePhysicsDamage( dmg )
    if ( self:Health() <= 0 ) then return end
    self:SetHealth( math.Clamp( self:Health() - dmg:GetDamage(), 0, self:GetMaxHealth() ) )

    if ( self:Health() <= 0 ) then
    local BoomBoom2 = ents.Create( "env_explosion" )
        BoomBoom2:SetKeyValue( "spawnflags", 144 )
        BoomBoom2:SetKeyValue( "iMagnitude", 15 )
        BoomBoom2:SetKeyValue( "iRadiusOverride", 256 )
        BoomBoom2:SetPos( self:GetPos() )
        BoomBoom2:Spawn()
        BoomBoom2:Fire( "explode", "", 0 )
		SafeRemoveEntity( self )
    end
end

function ENT:Think() 
end