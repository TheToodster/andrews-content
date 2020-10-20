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

Version: 2.0
Contact: Discord - The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/

Disclaimer: If you mess with anything inside this file and you break it then it's on you. Do not come to me for support. 
If you don't know what you are doing then don't touch it.

--]]------------------------------------------------------------

TOOL.Category = "Tood's Dispensers"
TOOL.Name = "Dispenser Tool"

if CLIENT then
    language.Add( "Tool.dispenser_tool.name", "Tood's Dispenser Tool v2" )
    language.Add( "Tool.dispenser_tool.desc", "Fill in the fields and left click to spawn the dispenser." )
    language.Add( "Tool.dispenser_tool.0", "" )
end

local AllVars = {
	NPCModel = "models/Combine_Super_Soldier.mdl",
	DispenserModel = "models/props/starwars/vehicles/bd_dispenser.mdl",
	NPCWeapon = "weapon_ar2",
	MinSpawnTime = "3",
	MaxSpawnTime = "8",
	NPCHealth = "1000",
	DispenserHealth = "5000",
	NPCAmount = "5",
	NPCWepDiff = "1",
	NPCRelations = "1",
}

table.Merge( TOOL.ClientConVar, AllVars )

function TOOL:LeftClick( tr )
if !tr.HitPos then return end

    if SERVER then
    local BringPod = ents.Create( "toods_dispenser" )
		self:AssignVars( BringPod )
		BringPod:PhysicsInit( SOLID_VPHYSICS ) -- Need to do physics here because it doesn't recognize the physics in the init.lua -_-
		BringPod:SetMoveType( MOVETYPE_VPHYSICS )
		BringPod:SetSolid( SOLID_VPHYSICS )
        BringPod:SetPos( tr.HitPos + Vector( 0, 0, 2000 ) )
        BringPod:Spawn()
        BringPod:Activate()

        undo.Create( "Dispenser" )
            undo.AddEntity( BringPod )
            undo.SetPlayer( self:GetOwner() )
            undo.SetCustomUndoText( "Dispenser Removed!" )
        undo.Finish()
    end
    return true 
end

function TOOL:AssignVars( Pod )
	for k, v in pairs( AllVars ) do
		Pod:SetKeyValue( k, self:GetClientInfo( k ) )
	end
end

local FindCVars = TOOL:BuildConVarList()

function TOOL.BuildCPanel( pnl )
    
	pnl:SetName( "Tood's Dispenser Tool v2" )
-------------------------------------------------------------------------------------------------------
    pnl:AddControl( "Header", { 
        Text = "Dispenser Tool", 
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
    pnl:TextEntry( "NPC Model", "dispenser_tool_NPCModel" )
    pnl:ControlHelp( "Sets the model of the NPC." )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "Dispenser Model", "dispenser_tool_DispenserModel" )
    pnl:ControlHelp( "Set the model of the dispenser itself." )
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
    pnl:NumSlider( "Dispenser Health", "dispenser_tool_DispenserHealth", 1000, 10000, 0 )
    pnl:ControlHelp( "Set the health of the dispenser itself." )
-------------------------------------------------------------------------------------------------------
	-- if you increase the max value of 20 then you need to add more vectors inside the init.lua file of the entity.
    pnl:NumSlider( "NPC Amount", "dispenser_tool_NPCAmount", 1, 20, 0 )
    pnl:ControlHelp( "How many NPCs should spawn from the dispenser." )
-------------------------------------------------------------------------------------------------------
	local WepBox = pnl:ComboBox( "Weapon Difficulty", "dispenser_tool_NPCWepDiff" )
	WepBox:AddChoice( "Poor", WEAPON_PROFICIENCY_POOR )
	WepBox:AddChoice( "Average", WEAPON_PROFICIENCY_AVERAGE )
	WepBox:AddChoice( "Good", WEAPON_PROFICIENCY_GOOD )
	WepBox:AddChoice( "Great", WEAPON_PROFICIENCY_VERY_GOOD )
	WepBox:AddChoice( "Perfect", WEAPON_PROFICIENCY_PERFECT )
	pnl:ControlHelp( "How good should these NPCs be when they fire their weapons." )
end
