

--[[--------------------------------------------------------------------------
	____________										   ___
	|		   |   									 	  |	  |
	|___	___|	__________   	__________			  |	  |
		|	|	   /		  \	   /		  \		   	  |	  |
		|	|	  |			   |  |			   |	  ____|   |
		|	|	  |			   |  |			   |	 / 		  |
		|	|	  |			   |  |			   |	|		  |
		|___|	   \__________/    \__________/		 \________|
		
--]]--------------------------------------------------------------------------



	RAIDBEGIN = true -- Change to false if you want to disable the raid timers and weapon spawns.


	RAID = RAID or {} -- DO NOT TOUCH THIS LINE HERE.


	-- How long until we raid shit? First value 60 is seconds so we multiply it by whatever to change to minutes.
	RAID.TimeUntilRaid =  60 * 30


	-- How long until the raid shit finishes? First value 60 is seconds so we multiply it by whatever to change it to minutes.
	RAID.WhenDoesRaidFinish = 60 * 15


	-- What message should appear on players screens when the raid begins.
	RAID.RaidBeginMessage = "The Raid has begun!"


	-- What message should appear on players screens when the raid ends.
	RAID.RaidEndMessage = "The Raid has now finished!"


	-- What text do you want the timer to have before the raid starts. 22 Characters MAX including spaces as a character each.
	RAID.TextUntilRaid = "The Raid will begin in"


	-- What text do you want the timer to have during the raid. 22 Characters MAX including spaces as a character each.
	RAID.TextDuringRaid = "The Raid will end in"


	-- Before the raid begins, what color should the text be.
	RAID.UntilRaidTextColor = Color( 255, 255, 255, 255 )


	-- During the raid, what color should the text be.
	RAID.DuringRaidTextColor = Color( 255, 0, 0, 255 )


	-- Before the raid begins, what color should the outline of the text be.
	RAID.UntilRaidTextOutline = Color( 120, 0, 0, 255 )


	-- During the raid, what color should the outline of the text be.
	RAID.DuringRaidTextOutline = Color( 0, 0, 0, 255 )

--[[-----------------------------------------------------
	Table Configuration
	Weapons, or entities can be used here.

	Simply copy and paste the weapon name from gmod into the "" below
	and that weapon or entity will spawn when the raid begins.
	So it should look something like
	RAID.GetEntity[1-15] = "weapon_name_here" or
	RAID.GetEntity[1-15] = "entity_name_here"
--]]-----------------------------------------------------

	RAID.GetEntity = {}

	RAID.GetEntity[1] = "weapon_shotgun"
	RAID.GetEntity[2] = "weapon_crossbow"
	RAID.GetEntity[3] = "weapon_smg1"
	RAID.GetEntity[4] = "weapon_357"
	RAID.GetEntity[5] = "weapon_ar2"
	RAID.GetEntity[6] = "weapon_smg1"
	RAID.GetEntity[7] = "weapon_ar2"
	RAID.GetEntity[8] = "weapon_357"
	RAID.GetEntity[9] = "weapon_ar2"
	RAID.GetEntity[10] = "weapon_smg1"
	RAID.GetEntity[11] = "weapon_ar2"
	RAID.GetEntity[12] = "weapon_rpg"
	RAID.GetEntity[13] = "weapon_357"
	RAID.GetEntity[14] = "weapon_ar2"
	RAID.GetEntity[15] = "weapon_rpg"

--[[-------------------------------------------------
	Table configuration.
	Coordinates

	In-game on the map of your choosing open up your console
	and type getpos then hit enter. Make sure you do this at the location you want the entity to spawn.
	A list of coordinates will pop up like
	setpos -308.468658 -111.654900 -11969.576172;setang 70.205437 79.357079 0.000000
	You want to copy the 1st 3 sets of numbers before the ; and paste them in Vector(here)
	DON'T FORGET YOUR COMMA AFTER THE 1ST AND 2ND SET
	So it should look something like this, using the coordinates above.
	RAID.DropPosition[5] = Vector( -308.468658, -111.654900, -11969.576172 )
--]]-------------------------------------------------

	RAID.DropPosition = {}

	RAID.DropPosition[1] = Vector( 500.076141, -163.165405, -12223.968750 )
	RAID.DropPosition[2] = Vector( 172.936569, -227.882889, -12223.968750 )
	RAID.DropPosition[3] = Vector( -95.037804, -549.862488, -12223.968750 )
	RAID.DropPosition[4] = Vector( -453.025543, -401.113678, -12223.968750 )
	RAID.DropPosition[5] = Vector( -531.022217, 20.905163, -12223.968750 )
	RAID.DropPosition[6] = Vector( -321.562347, 408.074219, -12223.968750 )
	RAID.DropPosition[7] = Vector( -402.337006, 581.093445, -12223.968750 )
	RAID.DropPosition[8] = Vector( -651.048889, 631.928772, -12223.968750 )
	RAID.DropPosition[9] = Vector( 7.227139, 693.764709, -12223.968750 )
	RAID.DropPosition[10] = Vector( 116.480339, 430.844208, -12223.968750 )
	RAID.DropPosition[11] = Vector( 431.932251, 424.780609, -12223.968750 )
	RAID.DropPosition[12] = Vector( 617.047607, 207.338165, -12223.968750 )
	RAID.DropPosition[13] = Vector( 830.495667, 437.812256, -12223.968750 )
	RAID.DropPosition[14] = Vector( 907.080566, 74.606628, -12223.968750 )
	RAID.DropPosition[15] = Vector( 818.662537, -153.848526, -12223.968750 )
