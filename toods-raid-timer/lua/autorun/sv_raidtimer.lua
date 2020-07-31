include( "sh_raidconfig.lua" )
AddCSLuaFile( "client/cl_toodsraiding.lua" )



--[[------------------------------------------------------------------------------
	____________										   ___
	|		   |   									 	  |	  |
	|___	___|	__________   	__________			  |	  |
		|	|	   /		  \	   /		  \		   	  |	  |
		|	|	  |			   |  |			   |	  ____|   |
		|	|	  |			   |  |			   |	 / 		  |
		|	|	  |			   |  |			   |	|		  |
		|___|	   \__________/    \__________/		 \________|
		
	DO NOT TOUCH THIS FILE IF YOU DO NOT UNDERSTAND IT!!!
	
	If you edit this file then you understand that I will not fix your mistakes.
	
	Author: Tood/The Toodster.
	Contact: Discord - @The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/
	Version: 1.0
	
--]]------------------------------------------------------------------------------
 
if SERVER then
	
	-- Begin the networking.
    util.AddNetworkString( "RaidTimerGoingDown" )
    util.AddNetworkString( "RaidBeginsNow" )

    RaidBeginsNow = false
	
    TimerForRaid = RAID.TimeUntilRaid
 
    function WhenDoesRaidFinish( ply )
	
        if RAIDBEGIN then
		
            timer.Create( "whendoesraidbegin", 1, 1, function()
			
                if RaidBeginsNow == false then
 
                    TimerForRaid = TimerForRaid - 1
 
                    WhenDoesRaidFinish()
 
                    if TimerForRaid < 1 then
 
                        RaidBeginsNow = true
						
                        TimerForRaid = RAID.WhenDoesRaidFinish
						
						for i = 1, 15 do
							local getwep = ents.Create( RAID.GetEntity[i] )
							getwep:SetPos( RAID.DropPosition[i] )
                            getwep:Activate()
                            getwep:Spawn()
						end

                        for k, v in pairs( player.GetAll() ) do
						
                                v:PrintMessage( HUD_PRINTCENTER, RAID.RaidBeginMessage )
							
                        end
						
                    end
					
                else
 
                    TimerForRaid = TimerForRaid - 1
					
                    WhenDoesRaidFinish()
 
                    if TimerForRaid < 1 then
 
                        RaidBeginsNow = false
						
                        TimerForRaid = RAID.TimeUntilRaid
 
						for i = 1, 15 do
                            for k, v in pairs( ents.FindByClass( RAID.GetEntity[i] ) ) do
						
                                if IsValid( v.Owner ) then continue end
							
                                    if v.Owner ~= v:GetOwner() then continue end
 
                                        v:Remove()
							
                            end
						end
 
                        for k, v in pairs( player.GetAll() ) do
						
							v:PrintMessage( HUD_PRINTCENTER, RAID.RaidEndMessage )
							
                        end
						
                    end
					
                end
				
            end )
 
            net.Start( "RaidBeginsNow" )
			
                net.WriteBool( RaidBeginsNow )
				
            net.Broadcast()
 
            net.Start( "RaidTimerGoingDown" )
			
                net.WriteFloat( TimerForRaid )
				
            net.Broadcast()
			
        end
		
    end
 
    hook.Add( "PlayerInitialSpawn", "RaidTimerForHUD", function( ply )
	
        net.Start( "RaidTimerGoingDown" )
		
            net.WriteFloat( TimerForRaid )
			
        net.Send( ply )
 
        net.Start( "RaidBeginsNow" )
		
            net.WriteBool( RaidBeginsNow )
			
        net.Send( ply )
		
    end )
 
    timer.Simple( 0, WhenDoesRaidFinish )
	
end