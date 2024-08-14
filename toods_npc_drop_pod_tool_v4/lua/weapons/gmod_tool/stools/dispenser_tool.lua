--[[--------------------------------------------------------------                                                                             
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

Version: 4.0
Contact: Discord - The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/

Disclaimer: If you mess with anything inside this file and you break it then it's on you. Do not come to me for support. 
If you don't know what you are doing then don't touch it.

--]]------------------------------------------------------------

TOOL.Category = "Tood's Drop Pods v3"
TOOL.Name = "Drop Pod Tool"

if CLIENT then

    TOOL.Information = {
        { name = "left" },
        { name = "reload" },
    }

    language.Add( "tool.dispenser_tool.name", "Tood's Drop Pod Tool v4" )
    language.Add( "tool.dispenser_tool.desc", "Customize the tool fields to your preference." )
    language.Add( "tool.dispenser_tool.left", "Spawn in the drop pod." )
    language.Add( "tool.dispenser_tool.reload", "Aim at the drop pod and hit your reload key to enable/disable repeat NPC spawning." )
end

local AllVars = {
	NPCClass = "npc_combine_s",
	DispenserModel = "models/props/starwars/vehicles/bd_dispenser.mdl",
	NPCWeapon = "weapon_ar2",
	NPCModel = "",
	MinSpawnTime = "3",
	MaxSpawnTime = "8",
	NPCHealth = "1000",
	DispenserHealth = "5000",
    DispenserHeight = "0",
	NPCAmount = "5",
	NPCWepDiff = "1",
	NPCRelations = "1",
    NPCRepeat = "0",
}

table.Merge( TOOL.ClientConVar, AllVars )

function TOOL:LeftClick( tr )
if !tr.HitPos then return end

    if SERVER then
    local BringPod = ents.Create( "toods_dispenser" )
		self:AssignVars( BringPod )
		BringPod:PhysicsInit( SOLID_VPHYSICS ) -- Need to do physics here because it doesn't recognize the physics in the init.lua -_-
		BringPod:SetMoveType( MOVETYPE_VPHYSICS )
		BringPod:SetSolid( SOLID_NONE )
        BringPod:SetPos( tr.HitPos + Vector( 0, 0, self:GetClientInfo( "DispenserHeight" ) ) )
        BringPod:Spawn()
        BringPod:Activate()
        if self:GetClientInfo( "NPCRepeat" ) == "1" then
            BringPod:SetNWBool( "T_POD.RepeatSpawns", true )
        else
            -- If I don't set this to false then sometimes the bool is set to true without anyone setting the bool to true.
            BringPod:SetNWBool( "T_POD.RepeatSpawns", false )
        end

        undo.Create( "Dispenser" )
            undo.AddEntity( BringPod )
            undo.SetPlayer( self:GetOwner() )
            undo.SetCustomUndoText( "Drop Pod Removed!" )
        undo.Finish()
    end
    return true 
end

function TOOL:AssignVars( Pod )
	for k, v in pairs( AllVars ) do
		Pod:SetKeyValue( k, self:GetClientInfo( k ) )
	end
end

function TOOL:Think()
    if !IsValid( self.GhostEntity ) then
        self:MakeGhostEntity( self:GetClientInfo( "DispenserModel" ), Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) )
    end
    self:CheckGhostPos( self.GhostEntity, self:GetOwner() )
end

function TOOL:Reload( tr )
    if tr.Entity:GetClass() != "toods_dispenser" then return false end

    local bool = tr.Entity:GetNWBool( "T_POD.RepeatSpawns", false )
    tr.Entity:SetNWBool( "T_POD.RepeatSpawns", not bool )
    local stat = tr.Entity:GetNWBool( "T_POD.RepeatSpawns" ) && "enabled!" || "disabled!"
    if CLIENT then
        notification.AddLegacy( "NPC Repeat spawning for this drop pod has been " .. stat, NOTIFY_UNDO, 2 )
    end
    return true
end

function TOOL:CheckGhostPos( ent, player )
    if !IsValid( ent ) then return end
    local tr = player:GetEyeTrace()
    if !tr.Hit then
        ent:SetNoDraw( true )
    end
    if ent:GetModel() != self:GetClientInfo( "DispenserModel" ) && ent:GetModel() != "" then
        ent:SetModel( self:GetClientInfo( "DispenserModel" ) )
    end
    ent:SetPos( tr.HitPos + Vector( 0, 0, tonumber( self:GetClientInfo( "DispenserHeight" ) ) ) )
    ent:SetNoDraw( false )
    ent:SetMaterial( "debug/debugspritewireframe", true )
end

local FindCVars = TOOL:BuildConVarList()

function TOOL.BuildCPanel( pnl )
    
	pnl:SetName( "Tood's Drop Pod Tool v3" )
-------------------------------------------------------------------------------------------------------
    pnl:AddControl( "Header", { 
        Text = "Drop Pod Tool", 
        Description = "Fill in the fields, aim at the ground and left click!" 
    } )
-------------------------------------------------------------------------------------------------------
	pnl:AddControl( "ComboBox", { 
		MenuButton = 1, 
		Folder = "dispenser_tool", 
		Options = { 
			[ "#preset.default" ] = FindCVars 
		}, 
		CVars = table.GetKeys( FindCVars ) 
	} )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "NPC Class", "dispenser_tool_NPCClass" )
    pnl:ControlHelp( "Paste the class of the NPC you want to use." )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "NPC Model", "dispenser_tool_NPCModel" )
    pnl:ControlHelp( "Paste the model path here to override the NPCs model. Leave blank if you want to use the NPCs default model." )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "Drop Pod Model", "dispenser_tool_DispenserModel" )
    pnl:ControlHelp( "Set the model of the drop pod itself." )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "NPC Weapon", "dispenser_tool_NPCWeapon" )
    pnl:ControlHelp( "What weapon should the NPC have, this is a weapon ID/class, not a model." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "Min Spawn Time", "dispenser_tool_MinSpawnTime", 1, 5, 0 )
    pnl:ControlHelp( "How long before the NPCs start spawning in." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "Max Spawn Time", "dispenser_tool_MaxSpawnTime", 6, 15, 0 )
    pnl:ControlHelp( "How long should it take for the last NPC to spawn in." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "NPC Health", "dispenser_tool_NPCHealth", 1, 10000, 0 )
    pnl:ControlHelp( "Set the health of the NPCs that spawn." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "Drop Pod Health", "dispenser_tool_DispenserHealth", 1000, 10000, 0 )
    pnl:ControlHelp( "Set the health of the drop pod itself." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "Drop Pod Height", "dispenser_tool_DispenserHeight", 0, 1000 )
    pnl:ControlHelp( "Set the position that the drop pod spawns in at. Useful for places with roofing or a low skybox." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "NPC Amount", "dispenser_tool_NPCAmount", 1, 15, 0 )
    pnl:ControlHelp( "How many NPCs should spawn from the drop pod. Do not choose more than 15 as spawn position screws up." )
-------------------------------------------------------------------------------------------------------
    pnl:CheckBox( "NPC Repeat Spawn", "dispenser_tool_NPCRepeat" )
    pnl:ControlHelp( "Everytime an NPC dies from the drop pod, should it be replaced by another NPC again and again if the drop pod hasn't been destroyed." )
-------------------------------------------------------------------------------------------------------
	local WepBox = pnl:ComboBox( "Weapon Difficulty", "dispenser_tool_NPCWepDiff" )
	WepBox:AddChoice( "Poor", WEAPON_PROFICIENCY_POOR )
	WepBox:AddChoice( "Average", WEAPON_PROFICIENCY_AVERAGE )
	WepBox:AddChoice( "Good", WEAPON_PROFICIENCY_GOOD )
	WepBox:AddChoice( "Great", WEAPON_PROFICIENCY_VERY_GOOD )
	WepBox:AddChoice( "Perfect", WEAPON_PROFICIENCY_PERFECT )
	pnl:ControlHelp( "How good should these NPCs be when they fire their weapons." )
-------------------------------------------------------------------------------------------------------
	local RelationBox = pnl:ComboBox( "NPC Relationship", "dispenser_tool_NPCRelations" )
	RelationBox:AddChoice( "Enemy", "1" )
	RelationBox:AddChoice( "Friendly", "3" )
	pnl:ControlHelp( "Choose how NPCs react to all players." )
end