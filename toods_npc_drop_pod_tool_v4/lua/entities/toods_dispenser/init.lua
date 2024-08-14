--[[------------------------------------------------------------------------------
                                                                       dddddddd
TTTTTTTTTTTTTTTTTTTTTTT                                                d::::::d
T:::::::::::::::::::::T                                                d::::::d
T:::::TT:::::::TT:::::T                                                d:::::d 
TTTTTT  T:::::T  TTTTTT   ooooooooooo       ooooooooooo         ddddddddd:::::d 
        T:::::T        o:::::::::::::::o o:::::::::::::::o   d::::::::::::::::d 
        T:::::T        o:::::ooooo:::::o o:::::ooooo:::::o  d:::::::ddddd:::::d 
        T:::::T        o::::o     o::::o o::::o     o::::o  d:::::d     d:::::d 
      TT:::::::TT      o:::::ooooo:::::o o:::::ooooo:::::o  d::::::ddddd::::::dd
      T:::::::::T       oo:::::::::::oo   oo:::::::::::oo     d:::::::::ddd::::d
      TTTTTTTTTTT         ooooooooooo       ooooooooooo        ddddddddd   ddddd

Version: 4.0
Contact: Discord - The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/

Disclaimer: If you mess with anything inside this file and you break it then it's on you. Do not come to me for support. 
If you don't know what you are doing then don't touch it.

--]]-------------------------------------------------------------------------------

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( "shared.lua" )

local SpawnedBy = {}

local NPCClass
local NPCModel
local NPCWeapon
local NPCHealth
local NPCAmount

local MinSpawn
local MaxSpawn

local RepeatNPC

local WepDiff
local NPCRelations

function ENT:KeyValue( TKey, TValue )
    if TKey == "NPCClass" then
        NPCClass = TValue
    end
	if TKey == "NPCModel" then
		NPCModel = TValue
	end
    if TKey == "DispenserModel" then
        self:SetModel( TValue )
    end
    if TKey == "NPCWeapon" then
        NPCWeapon = TValue
    end
    if TKey == "NPCHealth" then
        NPCHealth = TValue
    end
    if TKey == "MinSpawnTime" then
        MinSpawn = TValue
    end
    if TKey == "MaxSpawnTime" then
        MaxSpawn = TValue
    end
    if TKey == "DispenserHealth" then
        self:SetHealth( TValue )
		self:SetMaxHealth( TValue )
    end
    if TKey == "NPCAmount" then
        NPCAmount = TValue
    end
    if TKey == "NPCRepeat" then
        RepeatNPC = TValue
    end
	if TKey == "NPCWepDiff" then
		WepDiff = TValue
	end
	if TKey == "NPCRelations" then
		NPCRelations = TValue
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

local function IsEmpty( vec, ignore )

    local point = util.PointContents( vec )
    local a = point ~= CONTENTS_SOLID 
    and point ~= CONTENTS_MOVEABLE 
    and point ~= CONTENTS_LADDER 
    and point ~= CONTENTS_PLAYERCLIP 
    and point ~= CONTENTS_MONSTERCLIP

    local b = true

    for k, v in ipairs( ents.FindInSphere( vec, 125 ) ) do 
        if isentity( v ) and v != ignore then
            b = false
            break
        end
    end
    return b
end

local dist, area = 350, Vector( 16, 16, 64 )

local function FindEmpty( pos, ignore )
    if IsEmpty( pos, ignore ) and IsEmpty( pos + area, ignore ) then
        return pos
    end

    for _ = 1, 50 do
        local rand = Vector( math.random( - dist, dist ), math.random( - dist, dist ), 80 )

        local spawn = pos + rand

        if IsEmpty( spawn, ignore ) and IsEmpty( spawn + area, ignore ) then
            return spawn
        end
    end

    -- fallback.
    return FindEmpty( pos + Vector( math.random( 10, 20 ), math.random( 10, 20 ), 80 ) )
end

function ENT:SummonNPC( class, amount )
local AllNPCs = list.Get( "NPC" )
local CheckClass = AllNPCs[class]
if !CheckClass then return end
	for i = 1, amount do
		timer.Simple( math.random( MinSpawn, MaxSpawn ), function() 
			if IsValid( self ) then
			local SpawnNPC = ents.Create( CheckClass.Class )
			if !IsValid( SpawnNPC ) then return end
                SpawnNPC:SetPos( FindEmpty( self:GetPos(), SpawnNPC ) )
                local pos = SpawnNPC:GetPos()
                if pos == self:GetPos() then
                    SpawnNPC:SetPos( FindEmpty( pos ), SpawnNPC )
                end
				if NPCModel != "" then
					SpawnNPC:SetModel( NPCModel )
				elseif CheckClass.Model then
					SpawnNPC:SetModel( CheckClass.Model )
				end
				timer.Simple( 1, function() 
					SpawnNPC:SetHealth( NPCHealth )
					SpawnNPC:Give( NPCWeapon )
					SpawnNPC:SetCurrentWeaponProficiency( WepDiff )
					for k, ply in ipairs( player.GetAll() ) do
						if NPCRelations == "1" then
							SpawnNPC:AddEntityRelationship( ply, D_HT, 99 )
						elseif NPCRelations == "3" then
							SpawnNPC:AddEntityRelationship( ply, D_LI, 99 )
						end
						for k2, ent in ipairs( ents.FindByClass( "npc_*" ) ) do
							if ent:GetEnemy() == ply && ent:GetEnemy() != SpawnNPC then
								if NPCRelations == "1" then
									SpawnNPC:AddEntityRelationship( ent, D_LI, 99 )
									ent:AddEntityRelationship( SpawnNPC, D_LI, 99 )
								elseif NPCRelations == "3" then
									SpawnNPC:AddEntityRelationship( ent, D_HT, 99 )
									ent:AddEntityRelationship( SpawnNPC, D_HT, 99 ) -- For some reason ent doesn't attack SpawnNPC so I guess this is a quick fix?
								end
							end
						end
					end
					SpawnNPC:Spawn()
					SpawnNPC:Activate()
					SpawnedBy[SpawnNPC] = self
					SpawnNPC.CreatedByPod = self
				end )
			end
		end )
	end
end 

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
			local FetchClass = NPCClass
			self:SummonNPC( NPCClass, NPCAmount ) -- Call the function to spawn the NPCs.
            
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
    end
    self:SetMoveType( MOVETYPE_NONE )
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

hook.Add( "OnNPCKilled", "T_POD.CheckRepeatSpawns", function( npc, inf, att ) 
    if IsValid( npc ) then
        local ent = SpawnedBy[npc]
        if !IsValid( ent ) then return end
        if ent == npc.CreatedByPod then
            if ent:GetNWBool( "T_POD.RepeatSpawns", true ) != false then
                ent:SummonNPC( npc:GetClass(), 1 )
            end
        end
    end
end )