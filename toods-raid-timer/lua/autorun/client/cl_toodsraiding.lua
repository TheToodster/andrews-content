include( "sh_raidconfig.lua" )

RAID = RAID or {}

        surface.CreateFont( "ToodsFontV1", {
            font = "neuropol",
            size = 23,
            weight = 500,
            antialias = true
        } )

RaidBeginsNow = false

net.Receive( "RaidBeginsNow", function()

    RaidBeginsNow = net.ReadBool()
	
end )

        function ForTheRaid()
		
            if RAIDBEGIN then 
			
                net.Receive( "RaidTimerGoingDown", function()
				
                    CanWeRaidYet = net.ReadFloat() or 1
					
                end )

                CanWeRaidYet = CanWeRaidYet or 1
				
                local EndTheRaid = math.floor( CanWeRaidYet / 60 )
				
                local ToRaid = CanWeRaidYet - ( EndTheRaid * 60 )
				
                local littlethings = ":"

					if ToRaid < 10 then
				
						littlethings = ":0"
					
					end

                local background = Material( "scifibackgrounds/scifiplanet.png" )

                local timeronscreen = tonumber( EndTheRaid ) .. littlethings .. tonumber( ToRaid )
				
                local MathShit = ( math.sin( CurTime() ) + 1 ) / 2
				
                local DuringRaidColor = RAID.DuringRaidTextColor
				
                MoveTheText = math.abs( math.sin( CurTime() * 1.5 ) )
				
                local BeforeRaidColor = RAID.UntilRaidTextColor

					if RaidBeginsNow then
				
						BeforeRaidColor = Color( DuringRaidColor.r - ( MoveTheText * 145 ), DuringRaidColor.g - ( MoveTheText * 145 ), DuringRaidColor.b - ( MoveTheText * 145 ) )
					
							ColorOfOutline = RAID.DuringRaidTextOutline
					
					else
				
						BeforeRaidColor = RAID.UntilRaidTextColor
					
							ColorOfOutline = RAID.UntilRaidTextOutline
					
						end

                            surface.SetDrawColor( 125, 125, 125, 255 )
                            surface.SetMaterial( background )
                            surface.DrawRect( 10, 30, 300, 100 )
                            surface.DrawTexturedRect( 10, 30, 300, 100 )

                if RaidBeginsNow then
				
                    draw.SimpleTextOutlined( RAID.TextDuringRaid, "ToodsFontV1", ScrW() / 2 - 800, 50, BeforeRaidColor, TEXT_ALIGN_CENTER, 0, 1, ColorOfOutline )
					
				else

                    draw.SimpleTextOutlined( RAID.TextUntilRaid, "ToodsFontV1", ScrW() / 2 - 800, 50, BeforeRaidColor, TEXT_ALIGN_CENTER, 0, 1, ColorOfOutline )
					
                end

                draw.SimpleTextOutlined( timeronscreen, "ToodsFontV1", ScrW() / 2 - 800, 80, BeforeRaidColor, TEXT_ALIGN_CENTER, 0, 1, ColorOfOutline )
				
					end
				
				end

hook.Add( "HUDPaint", "ToodsRaidTimer", ForTheRaid )

timer.Simple( 1, ForTheRaid )