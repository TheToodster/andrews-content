--[[----------------------------------------------------------------------

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

	Support: discord.gg/YSzU6MY2Yb

	If you touch anything in this file and it breaks then ALL support is void.
	If you don't know what you're doing then don't touch it.

--]]----------------------------------------------------------------------

T_WOS = T_WOS || {}
local DmgTbl = {}

if SERVER then
	-- Choose item
	function T_WOS.ChooseItem()
		local total = 0
		for _, item in pairs( wOS.ItemIDTranslations ) do 
			local data = wOS:GetItemData( item )
			total = total + data.Rarity
		end

		for i = #wOS.ItemIDTranslations, 2, -1 do
			local rando = math.random( i )
			wOS.ItemIDTranslations[i], wOS.ItemIDTranslations[rando] = wOS.ItemIDTranslations[rando], wOS.ItemIDTranslations[i]
		end

		local rand = math.random( total )
		local num = 0
		for _, item in pairs( wOS.ItemIDTranslations ) do 
			local data = wOS:GetItemData( item )
			num = num + data.Rarity
			if rand <= num then
				return data.Name, data.Rarity
			end
		end
	end

	hook.Add( "EntityTakeDamage", "T_WOS.StorePlayerDamage", function( target, dmg ) 
		if ( target:IsNPC() || target:IsNextBot() ) && dmg:GetAttacker():IsPlayer() then
			local ply = dmg:GetAttacker()
			if T_WOS.Config.AllowedNPCs[target:GetClass()] then
				DmgTbl[ply] = ( DmgTbl[ply] || 0 ) + dmg:GetDamage()
			end
		end
	end )

	hook.Add( "OnNPCKilled", "T_WOS.CheckPlayerDamage", function( npc, killer ) 
		if IsValid( killer ) then
			if T_WOS.Config.AllowedNPCs[npc:GetClass()] then
				local SpawnLoot = ents.Create( "t_alcs_lootbox" )
				SpawnLoot:SetPos( npc:LocalToWorld( Vector( 0, 80, 10 ) ) )
				SpawnLoot:Spawn()
				SpawnLoot:Activate()
				local percent = T_WOS.Config.DamagePercent / 100
				for ply, dmg in pairs( DmgTbl ) do 
					if ( dmg / 100 ) >= ( npc:GetMaxHealth() * percent / 100 ) then
						ply:SetNWBool( "T_WOS.CanLoot." .. tostring( SpawnLoot:EntIndex() ), true )
					end
				end
				DmgTbl = {}
				timer.Simple( T_WOS.Config.LootboxDespawn, function() 
					if IsValid( SpawnLoot ) then
						SpawnLoot:Remove()
						for _, ply in pairs( player.GetAll() ) do 
							ply:SetNWBool( "T_WOS.CanLoot." .. tostring( SpawnLoot:EntIndex() ), false )
						end
					end
				end )
			end
		end
	end )
end