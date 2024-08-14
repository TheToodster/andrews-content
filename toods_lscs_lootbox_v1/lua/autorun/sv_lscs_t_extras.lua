T_LSCS = T_LSCS || {}
local DmgTbl = {}

if SERVER then
	-- Choose item
	function T_LSCS.ChooseItem()
		local total = 0

		for r, e in pairs( T_LSCS.Config.ItemsTbl ) do 
			total = total + e.rarity
		end

		local rand = math.random( total )
		local num = 0
		for r, e in pairs( T_LSCS.Config.ItemsTbl ) do 
			num = num + e.rarity
			if rand <= num then
				return e.items[math.random( #e.items )], e.rarity
			end
		end
	end

	hook.Add( "EntityTakeDamage", "T_LSCS.StorePlayerDamage", function( target, dmg ) 
		if target:IsNPC() && dmg:GetAttacker():IsPlayer() then
			local ply = dmg:GetAttacker()
			if T_LSCS.Config.NPCTbl[target:GetClass()] then
				DmgTbl[ply] = ( DmgTbl[ply] || 0 ) + dmg:GetDamage()
			end
		end
	end )

	hook.Add( "OnNPCKilled", "T_LSCS.CheckPlayerDamage", function( npc, killer ) 
		if IsValid( killer ) then
			if T_LSCS.Config.NPCTbl[npc:GetClass()] then
				local SpawnLoot = ents.Create( "lscs_lootbox" )
				SpawnLoot:SetPos( npc:LocalToWorld( Vector( 0, 80, 10 ) ) )
				SpawnLoot:Spawn()
				SpawnLoot:Activate()
				local percent = T_LSCS.Config.DamagePercent / 100
				for ply, dmg in pairs( DmgTbl ) do 
					if ( dmg / 100 ) >= ( npc:GetMaxHealth() * percent / 100 ) then
						ply:SetNWBool( "T_LSCS.CanLoot." .. tostring( SpawnLoot:EntIndex() ), true )
					end
				end
				DmgTbl = {}
			end
		end
	end )
end