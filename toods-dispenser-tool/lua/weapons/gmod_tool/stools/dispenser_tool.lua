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

Version: 1.0
Contact: Discord - The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/

Disclaimer: If you mess with anything inside this file and you break it then it's on you. Do not come to me for support. 
If you don't know what you are doing then don't touch it.

--]]------------------------------------------------------------

TOOL.Category = "Tood's Dispensers"
TOOL.Name = "Dispenser Tool"

if CLIENT then
    language.Add( "Tool.dispenser_tool.name", "Tood's Dispenser Tool v1" )
    language.Add( "Tool.dispenser_tool.desc", "Fill in the fields and left click to spawn the dispenser." )
    language.Add( "Tool.dispenser_tool.0", "" )
end

TOOL.ClientConVar["npcmodel"] = ""
TOOL.ClientConVar["dispensermodel"] = ""
TOOL.ClientConVar["npcweapon"] = ""
TOOL.ClientConVar["minspawn"] = "0"
TOOL.ClientConVar["maxspawn"] = "0"
TOOL.ClientConVar["npchealth"] = "0"
TOOL.ClientConVar["dispenserhealth"] = "0"
TOOL.ClientConVar["npcamount"] = "0"

function TOOL:LeftClick( tr )
if !tr.HitPos then return end
local NPCModel = self:GetClientInfo( "npcmodel" )
local PodModel = self:GetClientInfo( "dispensermodel" )
local NPCWeapon = self:GetClientInfo( "npcweapon" )
local NPCMinSpawn = self:GetClientNumber( "minspawn" )
local NPCMaxSpawn = self:GetClientNumber( "maxspawn" )
local NPCHealth = self:GetClientNumber( "npchealth" )
local PodHealth = self:GetClientNumber( "dispenserhealth" )
local NPCAmount = self:GetClientNumber( "npcamount" )

    if SERVER then
    local BringPod = ents.Create( "toods_dispenser" )
		BringPod:PhysicsInit( SOLID_VPHYSICS ) -- Need to do physics here because it doesn't recognize the physics in the init.lua -_-
		BringPod:SetMoveType( MOVETYPE_VPHYSICS )
		BringPod:SetSolid( SOLID_VPHYSICS )
        BringPod:SetKeyValue( "ModelNPC", NPCModel )
        BringPod:SetKeyValue( "ModelPod", PodModel )
        BringPod:SetKeyValue( "WeaponNPC", NPCWeapon )
        BringPod:SetKeyValue( "MinSpawn", NPCMinSpawn )
        BringPod:SetKeyValue( "MaxSpawn", NPCMaxSpawn )
        BringPod:SetKeyValue( "HealthNPC", NPCHealth )
        BringPod:SetKeyValue( "HealthPod", PodHealth )
        BringPod:SetKeyValue( "AmountNPC", NPCAmount )
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

function TOOL:RightClick( tr )
end

function TOOL.BuildCPanel( pnl )
    
	pnl:SetName( "Tood's Dispenser Tool v1" )
-------------------------------------------------------------------------------------------------------
    pnl:AddControl( "Header", { 
        Text = "Dispenser Tool", 
        Description = "Fill in the fields, aim at the ground and left click!" 
    } )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "NPC Model", "dispenser_tool_npcmodel" )
    pnl:ControlHelp( "Sets the model of the NPC." )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "Dispenser Model", "dispenser_tool_dispensermodel" )
    pnl:ControlHelp( "Set the model of the dispenser itself." )
-------------------------------------------------------------------------------------------------------
    pnl:TextEntry( "NPC Weapon", "dispenser_tool_npcweapon" )
    pnl:ControlHelp( "What weapon should the NPC have, this is a weapon ID/class, not a model." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "Min Spawn Time", "dispenser_tool_minspawn", 1, 5, 0 )
    pnl:ControlHelp( "How long before the NPCs start spawning in." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "Max Spawn Time", "dispenser_tool_maxspawn", 6, 15, 0 )
    pnl:ControlHelp( "How long should it take for the last NPC to spawn in." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "NPC Health", "dispenser_tool_npchealth", 1, 10000, 0 )
    pnl:ControlHelp( "Set the health of the NPCs that spawn." )
-------------------------------------------------------------------------------------------------------
    pnl:NumSlider( "Dispenser Health", "dispenser_tool_dispenserhealth", 1, 10000, 0 )
    pnl:ControlHelp( "Set the health of the dispenser itself." )
-------------------------------------------------------------------------------------------------------
	-- if you increase the max value of 20 then you need to add more vectors inside the init.lua file of the entity.
    pnl:NumSlider( "NPC Amount", "dispenser_tool_npcamount", 1, 20, 0 )
    pnl:ControlHelp( "How many NPCs should spawn from the dispenser." )
-------------------------------------------------------------------------------------------------------
end

