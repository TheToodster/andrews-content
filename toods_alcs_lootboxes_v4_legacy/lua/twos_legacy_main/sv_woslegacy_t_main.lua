--[[----------------------------------------------------------------------

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

	If you touch anything in this file and it breaks then ALL support is void.
	If you don't know what you're doing then don't touch it.

--]]----------------------------------------------------------------------

local NPCCache = {}
local DmgTbl = {}

function T_WOSLEGACY.ChooseLootbox( class )
	local total = 0
	local threshold = 30
	local stored = {}
	for name, data in pairs( T_WOSLEGACY.Config.LootTable ) do 
		if data.allowed_npcs[class] then
			stored[name] = data
			if data.rarity < threshold then
				data.rarity = data.rarity * 0.1
			end
			total = total + data.rarity
		end
	end

	-- Fisher-Yates
	for i = #T_WOSLEGACY.Config.LootTable, 2, -1 do 
		local rand = math.random( i )
		T_WOSLEGACY.Config.LootTable[i], T_WOSLEGACY.Config.LootTable[rand] = T_WOSLEGACY.Config.LootTable[rand], T_WOSLEGACY.Config.LootTable[i]
	end

	local rand = math.random( total )
	local num = 0
	for name, data in pairs( stored ) do 
		num = num + data.rarity
		if rand < num then
			return name
		end
	end
end

-- Choose item
function T_WOSLEGACY.ChooseItem( ent_name )
	local total = 0
	local threshold = 30
	for item, rarity in pairs( T_WOSLEGACY.Config.LootTable[ent_name].item_drops ) do 
		if rarity < threshold then
			rarity = rarity * 0.1
		end
		total = total + rarity
	end

	-- Fisher-Yates
	for i = #T_WOSLEGACY.Config.LootTable[ent_name].item_drops, 2, -1 do 
		local rand = math.random( i )
		T_WOSLEGACY.Config.LootTable[ent_name].item_drops[i], T_WOSLEGACY.Config.LootTable[ent_name].item_drops[rand] = T_WOSLEGACY.Config.LootTable[ent_name].item_drops[rand], T_WOSLEGACY.Config.LootTable[ent_name].item_drops[i]
	end
	
	local rand = math.random( total )
	local num = 0
	for item, rarity in pairs( T_WOSLEGACY.Config.LootTable[ent_name].item_drops ) do 
		num = num + rarity
		if rand <= num then
			return item, T_WOSLEGACY.Config.LootTable[ent_name].xp
		end
	end
end

-- Quick cache, there's probably a better method but oh well.
function T_WOSLEGACY.StoreNPCS()
	for lb, ld in pairs( T_WOSLEGACY.Config.LootTable ) do 
		for npc_class, _ in pairs( ld.allowed_npcs ) do 
			NPCCache[npc_class] = true
			PrintTable( NPCCache )
		end
	end
end
T_WOSLEGACY.StoreNPCS()

hook.Add( "EntityTakeDamage", "T_WOSLEGACY.StorePlayerDamage", function( target, dmg ) 
	if ( target:IsNPC() || target:IsNextBot() ) && dmg:GetAttacker():IsPlayer() then
		local ply = dmg:GetAttacker()
		if NPCCache[target:GetClass()] then
			DmgTbl[ply] = ( DmgTbl[ply] || 0 ) + dmg:GetDamage()
		end
	end
end )

hook.Add( "OnNPCKilled", "T_WOSLEGACY.CheckPlayerDamage", function( npc, killer )
    if IsValid( killer ) then
        for name, data in pairs( T_WOSLEGACY.Config.LootTable ) do
            if data.allowed_npcs[npc:GetClass()] then
                local choose_lootbox = T_WOSLEGACY.ChooseLootbox( npc:GetClass() )
                if choose_lootbox then
                    local new = string.lower( string.gsub( choose_lootbox, "[^%w]+", "_" ) )
                    local class = "t_loot_" .. new
                    local SpawnLoot = ents.Create( class )
                    if IsValid( SpawnLoot ) then
                        SpawnLoot:SetPos( npc:LocalToWorld( Vector( 0, 80, 10 ) ) )
                        SpawnLoot:Spawn()
                        SpawnLoot:Activate()
                        SpawnLoot:SetNWBool( "T_WOSLEGACY.NPCDrop", true )
                        local percent = T_WOSLEGACY.Config.DamagePercent / 100
                        for ply, dmg in pairs( DmgTbl ) do
                            if ( dmg / 100 ) >= ( npc:GetMaxHealth() * percent / 100 ) then
                                ply:SetNWBool( "T_WOSLEGACY.CanLoot." .. tostring( SpawnLoot:EntIndex() ), true )
                            end
                        end
                        DmgTbl = {}
                        timer.Simple( T_WOSLEGACY.Config.LootboxDespawn, function()
                            if IsValid( SpawnLoot ) then
                                SpawnLoot:SetNWBool("T_WOSLEGACY.NPCDrop", false )
                                SafeRemoveEntity( SpawnLoot )
                                for _, ply in pairs( player.GetAll() ) do
                                    ply:SetNWBool( "T_WOSLEGACY.CanLoot." .. tostring( SpawnLoot:EntIndex() ), false )
                                end
                            end
                        end )
                    else
                        print( "Failed to create lootbox: " .. class )
                    end
                end
                break
            end
        end
    end
end )