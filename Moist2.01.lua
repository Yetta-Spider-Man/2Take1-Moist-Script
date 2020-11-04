local rootPath = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
utils.make_dir(rootPath .. "\\Blacklist")
utils.make_dir(rootPath .. "\\lualogs")
utils.make_dir(rootPath .. "\\scripts\\MoistsLUA_cfg")

--DATA FILES
local scidFile = rootPath .. "\\Blacklist\\scid.list"
local kickdata = rootPath .. "\\scripts\\MoistsLUA_cfg\\Moist_Kicks.data"
local kickdata2 = rootPath .. "\\scripts\\MoistsLUA_cfg\\Moist_Kicks2.data"
local debugfile = rootPath.."\\lualogs\\Moists_debug.log"




local dataload = function()
	if not utils.file_exists(kickdata) then	return end
	for line in io.lines(kickdata) do data[#data + 1] = line end
	ui.notify_above_map(string.format("Moists Kick Data File 1 Loaded"), "Moists Script 2.0\nFile Load", 066)
end

local dataload2 = function()
	if not utils.file_exists(kickdata2) then	return end
	for line in io.lines(kickdata2) do data2[#data2 + 1] = line end
	ui.notify_above_map(string.format("Moists Kick Data File 2 Loaded"), "Moists Script 2.0\nFile Load", 066)
end



--output functions


function get_date_time()
	
	local d = os.date()
	
	local dtime = string.match(d, "%d%d:%d%d:%d%d")
	
	local dt = os.date("%d/%m/%y%y")
	Cur_Date_Time = (string.format("["..dt.."]".."["..dtime.."]"))
end

function debug_out(text)
	get_date_time()
	
	local file = io.open(rootPath.."\\lualogs\\Moists_debug.log", "a")
	io.output(file)
	io.write("\n"..Cur_Date_Time .."\n")
	io.write(text)
	io.close()
end


--Util functions
local notif = ui.notify_above_map

local function notify_above_map(msg)
	ui.notify_above_map(tostring("<font size='10'>~l~~o~" ..msg),  "~r~~h~Ω MoistsScript 2.0.1\n~l~~h~Private Edition", 203)
end

local function moist_notify(msg, color)

	ui.notify_above_map(tostring("<font size='10'>~l~~h~" ..msg), "~r~~h~Ω MoistsScript 2.0.1\n~l~~h~Private Edition", color)
end

--Get Offset to self POS
local SelfoffsetPos = v3()

local function Self_offsetPos(pos, heading, distance)
    heading = math.rad((heading - 180) * -1)
    return v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
end

function get_offset2me(dist)
	local pos = player.get_player_coords(player.player_id())
	print(string.format("%s, %s, %s", pos.x, pos.y, pos.z))
	SelfoffsetPos = Self_offsetPos(pos, player.get_player_heading(player.player_id()), dist)
	print(string.format("%s, %s, %s", Self_offsetPos.x, Self_offsetPos.y, Self_offsetPos.z))
end



--Script Settings Set & save
local save_ini = rootPath .. "\\scripts\\MoistsLUA_cfg\\MoistsScript_settings.ini"

local toggle_setting = {}
local setting = {}
toggle_setting[#toggle_setting+1] = "MoistsScript"
setting[toggle_setting[#toggle_setting]] = "2.0"
toggle_setting[#toggle_setting+1] = "PlyTracker.track_all"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "PlyTracker.track_all_HP"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "OSD.modvehgod_osd"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "OSD.modvehspeed_osd"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "OSD.modspec_osd"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "showfriends"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "OSD.Player_bar"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "aimDetonate_control"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "osd_date_time"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "force_wPara"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "force_wBPH"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "lag_out"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "global_func.mk1boostrefill"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "global_func.mk2boostrefill"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "global_func.veh_rapid_fire"
setting[toggle_setting[#toggle_setting]] = true
toggle_setting[#toggle_setting+1] = "global_func.rapidfire_hotkey1"



local save_ini_file = io.open(rootPath .. "\\scripts\\MoistsLUA_cfg\\MoistsScript_settings.ini", "a")
toggle = 1
if not utils.file_exists(rootPath .. "\\scripts\\MoistsLUA_cfg\\MoistsScript_settings.ini") then
	io.output(save_ini_file)
	io.write("[MoistsScript]")
	  io.close()
end

for line in io.lines(save_ini) do
		local line = string.gsub(line, toggle_setting[toggle] .. "=", "")
		if toggle == 1 and setting["MoistsScript"] ~= line then
		end
		if line == "true" then
			setting[toggle_setting[toggle]] = true
		elseif line == "false" then
			setting[toggle_setting[toggle]] = false
		elseif line ~= "nil" then
			if tonumber(line) ~= nil then
				setting[toggle_setting[toggle]] = tonumber(line)
			else
				setting[toggle_setting[toggle]] = line
			end
		end
		toggle = toggle + 1

end

function saveSettings()

			local save_ini = io.open(save_ini, "w")
			io.output(save_ini)
			for i, k in pairs(toggle_setting) do
				io.write(k.."="..tostring(setting[k]).."\n")
			end
			io.close(save_ini)
end


	



--Arrays of function variables

local OSD = {}
local PlyTracker = {}
local OptionsVar = {}
local tracking = {}
tracking.playerped_posi = {}
tracking.playerped_speed1 = {}
tracking.playerped_speed2 = {}
tracking.playerped_speed3 = {}
tracking.HP_tracker1 = {}
tracking.HP_tracker2 = {}
tracking.HP_tracker3 = {}

--Data & Entity Arrays
local escort = {}
local escortveh = {}
local groupIDs = {}
local allpeds = {}
local allveh = {}
local allobj = {}
local allpickups = {}

local scids = {}
local scidN = 0
local RemoveBlacklistFeature
--Function Variables

local pos_bool
local myplygrp
local plygrp
local Cur_Date_Time
local AnonymousBounty = true
local trigger_time = nil
local cleanup_done = true




--Modder Flag Variables
local mod_flag_1
local mod_flag_2
local mod_flag_3
local mod_flag_4
local mod_flag_5

--Modder Detection Hooks
local hook_id = 0
local hookID = 01
local hookID1 = 02
local hookID2 = 03
local hookID3 = 04
local hookID4 = 05
local hookID5 = 06
local hookID6 = 07


-- local NoWaypoint = v2()
-- NoWaypoint.x = 16000
-- NoWaypoint.y = 16000



--Modder Flagging
local int_flags = {65536, 131072, 262144, 524288, 1048576, 2097152, 4194304}
function modflag_set()
    for i = 1, #int_flags do
        if player.get_modder_flag_text(int_flags[i]) == "Moist Protex you" then
            mod_flag_1 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "You Kicked" then
            mod_flag_2 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "Spectating(with Mod)" then
            mod_flag_3 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "Blacklist" then
            mod_flag_4 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "netev_modder" then
            mod_flag_5 = int_flags[i]
        end
    end

    if mod_flag_1 == nil then
        mod_flag_1 = player.add_modder_flag("Moist Protex you")
    end

    if mod_flag_2 == nil then
        mod_flag_2 = player.add_modder_flag("You Kicked")
    end

    if mod_flag_3 == nil then
        mod_flag_3 = player.add_modder_flag("Spectating(with Mod)")
    end

    if mod_flag_4 == nil then
        mod_flag_4 = player.add_modder_flag("Blacklist")
    end

    if mod_flag_5 == nil then
        mod_flag_5 = player.add_modder_flag("netev_modder")
    end
end
modflag_set()


--Preset Data Arrays

local presets = {{"beyond_limits", -173663.281250,915722.000000,362299.750000},{"God Mode Death (Kill Barrier)", -1387.175,-618.242,30.362},{"Ocean God Mode Death\n(Outside Limits Deep Ocean)",  -5784.258301,-8289.385742,-136.411270},{"Chiliad", 491.176,5529.808,777.503},{"Lesters House", 1275.544,-1721.774,53.967},{"arena", -264.297,-1877.562,27.756},{"ElysianIslandBridge", -260.923,-2414.139,124.008},{"LSIAFlightTower", -983.292,-2636.995,89.524},{"TerminalCargoShip", 983.303,-2881.645,21.619},{"ElBurroHeights", 1583.022,-2243.034,93.265},{"CypressFlats", 552.672,-2218.876,68.981},{"LaMesa", 1116.815,-1539.787,52.146},{"SupplyStreet", 777.631,-695.813,28.763},{"Noose", 2438.874,-384.409,92.993},{"TatavianMountains", 2576.999,445.654,108.456},{"PowerStation", 2737.046,1526.873,57.494},{"WindFarm", 2099.765,1766.219,102.698},{"Prison", 1693.473,2652.971,61.335},{"SandyShoresRadioTower", 1847.034,3772.019,33.151},{"AlamoSea", 719.878,4100.993,39.154},{"RebelRadioTower", 744.500,2644.334,44.400},{"GreatChaparral", -291.035,2835.124,55.530},{"ZancudoControlTower", -2361.625,3244.962,97.876},{"NorthChumash(Hookies)", -2205.838,4298.805,48.270},{"AltruistCampRadioTower", -1036.141,4832.858,251.595},{"CassidyCreek", -509.942,4425.454,89.828},{"MountChiliad", 462.795,5602.036,781.400},{"PaletoBayFactory", -125.284,6204.561,40.164},{"GreatOceanHwyCafe", 1576.385,6440.662,24.654},{"MountGordoRadioTower", 2784.536,5994.213,354.275},{"MountGordoLighthouse", 3285.519,5153.820,18.527},{"GrapeSeedWaterTower", 1747.518,4814.711,41.666},{"TatavianMountainsDam", 1625.209,-76.936,166.651},{"VinewoodHillsTheater", 671.748,512.226,133.446},{"VinewoodSignRadioTowerTop", 751.179,1245.13,353.832},{"Hawik", 472.588,-96.376,123.705},{"PacificSrandardBank", 195.464,224.341,143.946},{"WestVinewoodCrane", -690.273,219.728,137.518},{"ArcadiasRadioTower", -170.232,-586.307,200.138},{"HookahPalaceSign",-1.414,-1008.324,89.189},{"MarinaAirportRadioTower",-697.010, -1419.530,5.001},{"DelperoFerrisWheel", -1644.193,-1114.271,13.029},{"VespucciCanalsClockTower", -1238.729,-853.861,77.758},{"DelPeroNrMazebankwest", -1310.777,-428.985,103.465},{"pacifficBluffs", -2254.199,326.088,192.606},{"GWC&GolfingSociety", -1292.052,286.209,69.407},{"Burton", -545.979,-196.251,84.733},{"LosSantosMedicalCenter", 431.907,-1348.709,44.673},{"BanhamCanyon", -3085.451,774.426,20.237},{"TongvaHills", -1874.280,2064.565,150.852},{"SanChianskiMountainRange", 2900.166,4325.987,102.101},{"HumaineLabs", 3537.104,3689.238,45.228},{"YouToolStoreSanChianski", 2761.944,3466.951,55.679},{"GalileoObservatory", -422.917,1133.272,325.855},{"GrndSeroraDesertCementwks", 1236.649,1869.214,84.824}}
local scriptEvents = {0x0fb7b2c5,0x1C2C3329,0x1f63a94e,0x4fbc297f,0x5f21fcaa,0x7b505065,0x7d556776,0x8b37581a,0x11fa24fa,0x073c8336,0x75bf07bc,0x75fc2a5e,0x96b17776,0x110b571b,0x222d2dab,0x231d58ee,0x692CC4BB,0x2073b3d7,0x2429d2da,0x8180e34a,0x13216f21,0x55274b5d,0x134771B8,0x6984116e,0x96308401,0xB54CD3F4,0xC2AD5FCE,0xCB79323D,0xF83B520C,0xaec17e3a,0xb513d7bd,0xba4adc62,0xcb14b6c0,0xe5010210,0xebee9424,0xfdb1f516,}
local escort_ped = {{"juggalo_01", 0xDB134533},{"topless_01", 0x9CF26183},{"juggalo_02", 0x91CA3E2C},{"lester crest", 0xB594F5C3},{"cop", 0x9AB35F63},{"mp_agent14", 0x6DBBFC8B},{"ramp_marine", 0x616C97B9},{"trafficwarden", 0xDE2937F3},{"lestercrest_2", 0x6E42FD26},{"lestercrest", 0x4DA6E849},{"agent14", 0xFBF98469},{"m_pros_01", 0x6C9DD7C9},{"waremech_01", 0xF7A74139},{"weapexp_01", 0x36EA5B09},{"weapwork_01", 0x4186506E},{"securoguard_01", 0xDA2C984E},{"armoured_01", 0xCDEF5408},{"armoured_01", 0x95C76ECD},{"armoured_02", 0x63858A4A},{"marine_01", 0xF2DAA2ED},{"marine_02", 0xF0259D83},{"security_01", 0xD768B228},{"snowcop_01", 0x1AE8BB58},{"prisguard_01", 0x56C96FC6},{"pilot_01", 0xE75B4B1C},{"pilot_02", 0xF63DE8E1},{"blackops_01", 0xB3F3EE34},{"blackops_02", 0x7A05FA59},{"blackops_03", 0x5076A73B},{"hwaycop_01", 0x739B1EF5},{"marine_01", 0x65793043},{"marine_02", 0x58D696FE},{"marine_03", 0x72C0CAD2},{"ranger_01", 0xEF7135AE},{"robber_01", 0xC05E1399},{"sheriff_01", 0xB144F9B9},{"pilot_01", 0xAB300C07},{"swat_01", 0x8D8F1B10},{"fibmugger_01", 0x85B9C668},{"juggernaut_01", 0x90EF5134},{"rsranger_01", 0x3C438CD2},}
local veh_list = {{"buzzard", 0x2F03547B, nil, nil},{"savage", 0xFB133A17, nil, nil},{"seasparrow", 0xD4AE63D9, 10, 1},{"valkyrie2", 0x5BFA5C4B, nil, nil},{"valkyrie", 0xA09E15FD, nil, nil},{"boxville5", 0x28AD20E1, nil, nil},{"apc", 0x2189D250, 10, 0},{"oppressor2", 0x7B54A9D3, 10, 1},{"oppressor", 0x34B82784, 10, 0},{"ruiner2", 0x381E10BD, nil, nil},{"scramjet", 0xD9F0503D, 10, 0},{"stromberg", 0x34DBA661},{"tampa3", 0xB7D9F7F1},{"khanjali", 0xAA6F980A, nil, nil},{"insurgent3", 0x8D4B7A8A, nil, nil},{"insurgent", 0x9114EADA, nil, nil},{"limo2", 0xF92AEC4D, nil, nil},{"mower", 0x6A4BD8F6, nil, nil},{"police2", 0x9F05F101, nil, nil},{"police3", 0x71FA16EA, nil, nil},{"police4", 0x8A63C7B9, nil, nil},{"police", 0x79FBB0C5, nil, nil},{"policeb", 0xFDEFAEC3, nil, nil},{"policeold1", 0xA46462F7, nil, nil},{"policeold2", 0x95F4C618, nil, nil},{"policet", 0x1B38E955, nil, nil},{"polmav", 0x1517D4D9, nil, nil},{"sheriff2", 0x72935408, nil, nil},{"sheriff", 0x9BAA707C, nil, nil},{"phantom2", 0x9DAE1398, nil, nil},{"ruiner3", 0x2E5AFD37, nil, nil},}
local ped_wep = {{"unarmed", 0xA2719263},{"weapon_handcuffs", 0xD04C944D},{"stone_hatchet", 0x3813FC08},{"knife", 0x99B507EA},{"bat", 0x958A4A8F},{"weapon_machinepistol", 0xDB1AA450},	{"raypistol", 0xAF3696A1},{"stungun", 0x3656C8C1},{"raycarbine", 0x476BF15},{"combatmg_mk2", 0xDBBD7280},{"rpg", 0xB1CA77B1},{"railgun", 0x6D544C99},{"minigun", 0x42BF8A85},{"rayminigun", 0xB62D1F6},}
local missions = {"Force to Severe Weather","Force to Half Track","Force to Half Track","Force to Night Shark AAT","Force to Night Shark AAT","Force to APC Mission","Force to APC Mission","Force to MOC Mission","Force to MOC Mission","Force to Tampa Mission","Force to Tampa Mission","Force to Opressor Mission1","Force to Opressor Mission1","Force to Opressor Mission2","Force to Opressor Mission2"}
local BountyPresets = {0,1,42,69,420,666,1000,3000,5000,7000,9000,10000}

--Event Data Arrays

local NetEvents = {
NetEvents[0] = "OBJECT_ID_FREED_EVENT"
NetEvents[1] = "OBJECT_ID_REQUEST_EVENT"
NetEvents[2] = "ARRAY_DATA_VERIFY_EVENT"
NetEvents[3] = "SCRIPT_ARRAY_DATA_VERIFY_EVENT"
NetEvents[4] = "REQUEST_CONTROL_EVENT"
NetEvents[5] = "GIVE_CONTROL_EVENT"
NetEvents[6] = "WEAPON_DAMAGE_EVENT"
NetEvents[7] = "REQUEST_PICKUP_EVENT"
NetEvents[8] = "REQUEST_MAP_PICKUP_EVENT"
NetEvents[9] = "GAME_CLOCK_EVENT"
NetEvents[10] = "GAME_WEATHER_EVENT"
NetEvents[11] = "RESPAWN_PLAYER_PED_EVENT"
NetEvents[12] = "GIVE_WEAPON_EVENT"
NetEvents[13] = "REMOVE_WEAPON_EVENT"
NetEvents[14] = "REMOVE_ALL_WEAPONS_EVENT"
NetEvents[15] = "VEHICLE_COMPONENT_CONTROL_EVENT"
NetEvents[16] = "FIRE_EVENT"
NetEvents[17] = "EXPLOSION_EVENT"
NetEvents[18] = "START_PROJECTILE_EVENT"
NetEvents[19] = "UPDATE_PROJECTILE_TARGET_EVENT"
NetEvents[21] = "BREAK_PROJECTILE_TARGET_LOCK_EVENT"
NetEvents[20] = "REMOVE_PROJECTILE_ENTITY_EVENT"
NetEvents[22] = "ALTER_WANTED_LEVEL_EVENT"
NetEvents[23] = "CHANGE_RADIO_STATION_EVENT"
NetEvents[24] = "RAGDOLL_REQUEST_EVENT"
NetEvents[25] = "PLAYER_TAUNT_EVENT"
NetEvents[26] = "PLAYER_CARD_STAT_EVENT"
NetEvents[27] = "DOOR_BREAK_EVENT"
NetEvents[28] = "SCRIPTED_GAME_EVENT"
NetEvents[29] = "REMOTE_SCRIPT_INFO_EVENT"
NetEvents[30] = "REMOTE_SCRIPT_LEAVE_EVENT"
NetEvents[31] = "MARK_AS_NO_LONGER_NEEDED_EVENT"
NetEvents[32] = "CONVERT_TO_SCRIPT_ENTITY_EVENT"
NetEvents[33] = "SCRIPT_WORLD_STATE_EVENT"
NetEvents[40] = "INCIDENT_ENTITY_EVENT"
NetEvents[34] = "CLEAR_AREA_EVENT"
NetEvents[35] = "CLEAR_RECTANGLE_AREA_EVENT"
NetEvents[36] = "NETWORK_REQUEST_SYNCED_SCENE_EVENT"
NetEvents[37] = "NETWORK_START_SYNCED_SCENE_EVENT"
NetEvents[39] = "NETWORK_UPDATE_SYNCED_SCENE_EVENT"
NetEvents[38] = "NETWORK_STOP_SYNCED_SCENE_EVENT"
NetEvents[41] = "GIVE_PED_SCRIPTED_TASK_EVENT"
NetEvents[42] = "GIVE_PED_SEQUENCE_TASK_EVENT"
NetEvents[43] = "NETWORK_CLEAR_PED_TASKS_EVENT"
NetEvents[44] = "NETWORK_START_PED_ARREST_EVENT"
NetEvents[45] = "NETWORK_START_PED_UNCUFF_EVENT"
NetEvents[46] = "NETWORK_SOUND_CAR_HORN_EVENT"
NetEvents[47] = "NETWORK_ENTITY_AREA_STATUS_EVENT"
NetEvents[48] = "NETWORK_GARAGE_OCCUPIED_STATUS_EVENT"
NetEvents[49] = "PED_CONVERSATION_LINE_EVENT"
NetEvents[50] = "SCRIPT_ENTITY_STATE_CHANGE_EVENT"
NetEvents[51] = "NETWORK_PLAY_SOUND_EVENT"
NetEvents[52] = "NETWORK_STOP_SOUND_EVENT"
NetEvents[53] = "NETWORK_PLAY_AIRDEFENSE_FIRE_EVENT"
NetEvents[54] = "NETWORK_BANK_REQUEST_EVENT"
NetEvents[55] = "NETWORK_AUDIO_BARK_EVENT"
NetEvents[56] = "REQUEST_DOOR_EVENT"
NetEvents[58] = "NETWORK_TRAIN_REQUEST_EVENT"
NetEvents[57] = "NETWORK_TRAIN_REPORT_EVENT"
NetEvents[59] = "NETWORK_INCREMENT_STAT_EVENT"
NetEvents[60] = "MODIFY_VEHICLE_LOCK_WORD_STATE_DATA"
NetEvents[61] = "MODIFY_PTFX_WORD_STATE_DATA_SCRIPTED_EVOLVE_EVENT"
NetEvents[62] = "REQUEST_PHONE_EXPLOSION_EVENT"
NetEvents[63] = "REQUEST_DETACHMENT_EVENT"
NetEvents[64] = "KICK_VOTES_EVENT"
NetEvents[65] = "GIVE_PICKUP_REWARDS_EVENT"
NetEvents[66] = "NETWORK_CRC_HASH_CHECK_EVENT"
NetEvents[67] = "BLOW_UP_VEHICLE_EVENT"
NetEvents[68] = "NETWORK_SPECIAL_FIRE_EQUIPPED_WEAPON"
NetEvents[69] = "NETWORK_RESPONDED_TO_THREAT_EVENT"
NetEvents[70] = "NETWORK_SHOUT_TARGET_POSITION"
NetEvents[71] = "VOICE_DRIVEN_MOUTH_MOVEMENT_FINISHED_EVENT"
NetEvents[72] = "PICKUP_DESTROYED_EVENT"
NetEvents[73] = "UPDATE_PLAYER_SCARS_EVENT"
NetEvents[74] = "NETWORK_CHECK_EXE_SIZE_EVENT"
NetEvents[75] = "NETWORK_PTFX_EVENT"
NetEvents[76] = "NETWORK_PED_SEEN_DEAD_PED_EVENT"
NetEvents[77] = "REMOVE_STICKY_BOMB_EVENT"
NetEvents[78] = "NETWORK_CHECK_CODE_CRCS_EVENT"
NetEvents[79] = "INFORM_SILENCED_GUNSHOT_EVENT"
NetEvents[80] = "PED_PLAY_PAIN_EVENT"
NetEvents[81] = "CACHE_PLAYER_HEAD_BLEND_DATA_EVENT"
NetEvents[82] = "REMOVE_PED_FROM_PEDGROUP_EVENT"
NetEvents[83] = "REPORT_MYSELF_EVENT"
NetEvents[84] = "REPORT_CASH_SPAWN_EVENT"
NetEvents[85] = "ACTIVATE_VEHICLE_SPECIAL_ABILITY_EVENT"
NetEvents[86] = "BLOCK_WEAPON_SELECTION"
NetEvents[87] = "NETWORK_CHECK_CATALOG_CRC"
}

--Feature & Variable Arrays
local globalFeatures = {}
local playerFeatures = {}
playerfeatVars = {} 
playerFeat = {}
playerFeatParent = {}
playerFeatParent2 = {}
playerFeat1 = {}
playerFeat2 = {}
playerFeat3 = {}
playerFeat4 = {}

--local Menu Functions
globalFeatures.parent = menu.add_feature("Moists Script 2.0", "parent", 0).id
playersFeature = menu.add_feature("Online Players", "parent", globalFeatures.parent)
globalFeatures.lobby = menu.add_feature("Online Session", "parent", globalFeatures.parent).id
-- globalFeatures.protex = menu.add_feature("Online Protection", "parent", globalFeatures.lobby).id
-- globalFeatures.kick = menu.add_feature("Session Kicks", "parent", globalFeatures.lobby).id
-- globalFeatures.orbital = menu.add_feature("Orbital Room Block", "parent", globalFeatures.protex).id
globalFeatures.self = menu.add_feature("Player Functions", "parent", globalFeatures.parent).id
globalFeatures.cleanup = menu.add_feature("Clean Shit Up!", "parent", globalFeatures.parent).id
globalFeatures.self_ped = menu.add_feature("Player Ped Functions", "parent", globalFeatures.self).id
globalFeatures.self_wep = menu.add_feature("Player Ped Weapons", "parent", globalFeatures.self_ped).id
globalFeatures.self_veh = menu.add_feature("Player Vehicle Functions", "parent", globalFeatures.self).id
globalFeatures.self_options = menu.add_feature("Player Options", "parent", globalFeatures.self).id
globalFeatures.createdmarkers = menu.add_feature("Markers", "parent", globalFeatures.cleanup).id
globalFeatures.createdmarkers = menu.add_feature("Markers", "parent", globalFeatures.cleanup).id
globalFeatures.moistopt = menu.add_feature("Options", "parent", globalFeatures.parent).id

-- globalFeatures.moist_test = menu.add_feature("Test", "parent", 0)
-- globalFeatures.moist_test.hidden = false

--save settings			
menu.add_feature("Save settings", "action", globalFeatures.moistopt, function()
	saveSettings()
	moist_notify("Settings saved!", 212)
end) 
	

--online Menu Functions

playerfeatVars.f = menu.add_player_feature("Spawn Options", "parent", 0).id
playerfeatVars.b = menu.add_player_feature("Ped Spawns", "parent", playerfeatVars.f).id 
playerfeatVars.fm = menu.add_player_feature("Force Player to Mission", "parent", 0).id
-- globalFeatures.parentID = menu.add_feature("Blacklist", "parent", globalFeatures.protex).id



--player Features --Griefing

menu.add_player_feature("CEO BAN", "action", 0, function(feat, pid)
	   
     script.trigger_script_event(0xC2AD5FCE, pid, {0, 1, 5, 0})
end)
 
menu.add_player_feature("CEO DISMISS", "action", 0, function(feat, pid)
   script.trigger_script_event(0x96308401, pid, {0, 1, 5})
end)

menu.add_player_feature("CEO TERMINATE", "action", 0, function(feat, pid)
    script.trigger_script_event(0x96308401, pid, {1, 1, 6})
	script.trigger_script_event(0x96308401, pid, {0, 1, 6, 0})
end)

for i = 1, #missions do
	local y = #missions - 1
	menu.add_player_feature("Force to Mission" ..missions[i], "action", playerfeatVars.fm, function(feat, pid)
	
	script.trigger_script_event(0x692CC4BB, pid,{y})
	end)
end


--Functions

local global_func = {}

function playervehspd(pid, speed)
    local plyveh
    local pedd = player.get_player_ped(pid)
    plyveh = player.get_player_vehicle(pid)
    network.request_control_of_entity(plyveh)
    entity.set_entity_max_speed(plyveh, speed)
end


function playvehspdboost(pid, reftime)
    --- lag 100000.000010
    --- fast 0.000010
    local plyveh
    plyveh = player.get_player_vehicle(pid)
    network.request_control_of_entity(plyveh)
    vehicle.set_vehicle_rocket_boost_refill_time(plyveh, reftime)
end



--Options Toggles etc

global_func.lag_out = menu.add_feature("Lag Self out of session", "toggle", globalFeatures.moistopt, function(feat)
	setting["lag_out"] = true
		if feat.on then			
			local key = MenuKey()
			key:push_str("LCONTROL")
			key:push_str("LSHIFT")
			key:push_str("l")  
			if key:is_down() then
				local time = utils.time_ms() + 8500
				while time > utils.time_ms() do end
				system.wait(1200)
			end
			return HANDLER_CONTINUE
		end	
		setting["lag_out"] = false
		return HANDLER_POP
end)
global_func.lag_out.on = setting["lag_out"]



--Self Functions

--Self modifiers --Max Health 0:0 1: 2: 3: 4: 5: 6:
local HP_modifiers = {
{"Set max Health 0 (UnDead OTR)", "0"},
{"Set Health to 500", "500"},
{"Set Health to 10000", "1000"},
{"Set Health Freemode Beast 2500", "2500"},
{"Set Health BallisticArmour 2600", "2600"},
{"Set Health to 10000", "10000"},
{"Set Health to 90000", "90000"},
{"Set Health to 328 (lvl 120)", "328"},
}

globalFeatures.self_ped_modify = menu.add_feature(HP_modifiers[i][1], globalFeatures.self_ped).id

for i = 1, #HP_modifiers do
	menu.add_feature(HP_modifiers[i][1], globalFeatures.self_ped_modify, function(feat)
	
	local me = player.get_player_ped(player.player_id())
	
	local chp
	ped.set_ped_max_health(me, HP_modifiers[i][2])
	chp = tostring(ped.get_ped_max_health(me))
	ui.notify_above_map(string.format("Max Health %s Set and filled", chp), "Self Modifier", 23)
	ped.set_ped_max_health(me, HP_modifiers[i][2])
	ped.set_ped_health(me, HP_modifiers[i][2])
	return HANDLER_POP
	end)
end



global_func.self = menu.add_feature("Put Handcuffs on Self", "action", globalFeatures.self_ped, function(feat)
	local pped = player.get_player_ped(player.player_id())
	if ped.get_ped_drawable_variation(pped, 7) == 25 then
	ped.set_ped_component_variation(pped, 7, 0, 0, 0)
	else
	ped.set_ped_component_variation(pped, 7, 25, 0, 0)
	end
end)

global_func.self = menu.add_feature("Set Handcuffs Locked Position", "action", globalFeatures.self_ped, function(feat)
	local pped = player.get_player_ped(player.player_id())
	ped.set_ped_component_variation(pped, 7, 25, 0, 0)
	weapon.give_delayed_weapon_to_ped(pped, ped_wep[2][2], 0, 1)
end)

global_func.self = menu.add_feature("White Team parachute Pack", "action", globalFeatures.self_ped, function(feat)

	local pped = player.get_player_ped(player.player_id())
	ped.get_ped_drawable_variation(pped, 5)
	ped.set_ped_component_variation(pped, 5, 58, 8, 0)

end)
	
global_func.force_wPara = menu.add_feature("Force White parachute On", "toggle", globalFeatures.self_ped, function(feat)
	setting["force_wPara"] = true
	if feat.on then
	local pped = player.get_player_ped(player.player_id())
	
	if ped.get_ped_drawable_variation(pped, 5) ~= 58 then
	ped.set_ped_component_variation(pped, 5, 58, 8, 0)
	end
	system.wait(600)
	return HANDLER_CONTINUE
	end
	setting["force_wPara"] = false
	return HANDLER_POP
	
end)
global_func.force_wPara.on = setting["force_wPara"]
	
global_func.force_wBPH = menu.add_feature("Force White BPH On", "toggle", globalFeatures.self_ped, function(feat)
	setting["force_wBPH"] = true
	if feat.on then
	local pped = player.get_player_ped(player.player_id())
	
	if ped.get_ped_prop_index(pped, 0) ~= 59 then
	ped.set_ped_prop_index(pped, 0, 59, 8, 0)
	end
	system.wait(600)
	return HANDLER_CONTINUE
	end
	setting["force_wBPH"] = false
	return HANDLER_POP
	
end)
global_func.force_wBPH.on = setting["force_wBPH"]


global_func.mk1boostrefill = menu.add_feature("Boost Recharge v.2 MK1 Opressor (self)", "toggle", globalFeatures.selfveh, function(feat)
		setting["global_func.mk1boostrefill"] = true
		if feat.on then
			local myped = player.get_player_ped(player.player_id())
			if ped.is_ped_in_any_vehicle(myped) == true then
				local Curveh = ped.get_vehicle_ped_is_using(myped)
				if vehicle.is_vehicle_rocket_boost_active(Curveh) == false then
					return HANDLER_CONTINUE
				end
				system.wait(2000)
				vehicle.set_vehicle_rocket_boost_percentage(Curveh, 100.00)
			end
			return HANDLER_CONTINUE
		end
		setting["global_func.mk1boostrefill"] = false
		return HANDLER_POP

end)
global_func.mk1boostrefill.on = setting["global_func.mk1boostrefill"]

global_func.mk2boostrefill = menu.add_feature("MK2 Boost Insta-Recharge (self)", "toggle", globalFeatures.selfveh, function(feat)
		setting["global_func.mk2boostrefill"] = true

		if feat.on then
			local myped = player.get_player_ped(player.player_id())
			if ped.is_ped_in_any_vehicle(myped) == true then
				local Curveh = ped.get_vehicle_ped_is_using(myped)
				vehicle.set_vehicle_rocket_boost_refill_time(Curveh, 0.000001)
			end
			return HANDLER_CONTINUE
		end
		setting["global_func.mk2boostrefill"] = false
		return HANDLER_POP

end)
global_func.mk2boostrefill.on = setting["global_func.mk2boostrefill"]

global_func.veh_rapid_fire = menu.add_feature("MK2 Rapid Fire Missiles (self)", "toggle", globalFeatures.selfveh, function(feat)
	setting["global_func.veh_rapid_fire"] = true
	if feat.on then
		local myped = player.get_player_ped(player.player_id())
		if ped.is_ped_in_any_vehicle(myped) == true then
			local Curveh = ped.get_vehicle_ped_is_using(myped)
			vehicle.set_vehicle_fixed(Curveh)
			vehicle.set_vehicle_deformation_fixed(Curveh)
		end
		return HANDLER_CONTINUE
	end
	setting["global_func.veh_rapid_fire"] = false
	return HANDLER_POP
end)
global_func.veh_rapid_fire.on = setting["global_func.veh_rapid_fire"]

global_func.rapidfire_hotkey1 = menu.add_feature("mk2 rapid fire hotkey", "toggle", globalFeatures.self_options.id, function(feat)
	setting["global_func.rapidfire_hotkey1"] = true
	if feat.on then
		local key = MenuKey()
		key:push_str("LCONTROL")
		key:push_str("r")
		if key:is_down() then
			mk2_rapid_fire.on = not mk2_rapid_fire.on
				notify_above_map(string.format("Switching Rapid Fire %s\n%s for your Current Vehicle", mk2_rapid_fire.on and "ON" or "OFF", mk2_rapid_fire.on and "Glitch On" or "Set Repaired"))
			system.wait(1200)
		end
	end
	return HANDLER_CONTINUE
	setting["global_func.rapidfire_hotkey1"] = false
	return HANDLER_POP
end)
global_func.rapidfire_hotkey1.on = setting["global_func.rapidfire_hotkey1"]




--Util functions
local notif = ui.notify_above_map

local function notify_above_map(msg)
	ui.notify_above_map(tostring("<font size='10'>~l~~o~" ..msg),  "~r~~h~Ω MoistsScript 2.0.1\n~l~~h~Private Edition", 203)
end

local function moist_notify(msg, color)

	ui.notify_above_map(tostring("<font size='10'>~l~~h~" ..msg), "~r~~h~Ω MoistsScript 2.0.1\n~l~~h~Private Edition", color)
end

--Better Randomisation for Math functions
math.randomseed(utils.time_ms())


local function set_waypoint(pos)
	pos = pos or player.get_player_coords(player.player_id())
	if pos.x and pos.y then
		local coord = v2()
		coord.x = pos.x
		coord.y = pos.y
		ui.set_new_waypoint(coord)
	end
end



--offset to player calculation
local Self_offsetPos = v3()
function OffsetCoords(pos, heading, distance)
    heading = math.rad((heading - 180) * -1)
    return v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
end

function get_offset(pid, dist)
	local pos = player.get_player_coords(pid)
	print(string.format("%s, %s, %s", pos.x, pos.y, pos.z))
	Self_offsetPos = OffsetCoords(pos, player.get_player_heading(pid), dist)

	print(string.format("%s, %s, %s", Self_offsetPos.x, Self_offsetPos.y, Self_offsetPos.z))
	return Self_offsetPos	
end


--spawn variables defaults set
model = 0xDB134533
vehhash = 788747387
wephash = 0xA2719263
local mod
local modvalue
local pedspawns


--Spawn Functions

local function spawn_ped(pid, pedhash, offdist, attack)
	local hash = pedhash
	plygrp =  player.get_player_group(pid)
	local pedp = player.get_player_ped(pid)
    local pos = player.get_player_coords(pid)
    local offset = v3()
	local offset2 = v3()

    local headtype = math.random(0, 2)

	offset = get_offset(pid, offdist)
	

	streaming.request_model(hash)
	while not streaming.has_model_loaded(hash) do
		
		system.wait(10)
	end
    local p = #escort + 1
	print(hash)

    escort[p] = ped.create_ped(26, hash, offset, 0, true, false)
	print(escort[p])		
	entity.set_entity_god_mode(escort[p], true)
	ui.add_blip_for_entity(escort[p])
	ped.set_ped_component_variation(escort[p], 0, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 2, 0, 0, 0)
    ped.set_ped_component_variation(escort[p], 3, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 4, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 0, 2, 2, 0)
	ped.set_ped_component_variation(escort[p], 8, 1, 0, 0)
	
    ped.set_ped_can_switch_weapons(escort[p], true)
    ped.set_ped_combat_attributes(escort[p], 46, true)
    ped.set_ped_combat_attributes(escort[p], 52, true)
    ped.set_ped_combat_attributes(escort[p], 1, true)
    ped.set_ped_combat_attributes(escort[p], 2, true)
    ped.set_ped_combat_range(escort[p], 2)
    ped.set_ped_combat_ability(escort[p], 2)
    ped.set_ped_combat_movement(escort[p], 2)
	ped.set_ped_can_switch_weapons(escort[p], true)
	
	if not attack == true then
	ped.set_ped_combat_attributes(escort[p], 1424, false)
	pedgroup = ped.get_ped_group(escort[p])
	ped.set_ped_as_group_member(escort[p], plygrp)
	pedgroup = ped.get_ped_group(escort[p])
	ped.set_ped_never_leaves_group(escort[p], true)

	else
	end
	streaming.set_model_as_no_longer_needed(hash)	
end

local function spawn_ped_v2(pid, pedhash, attack)
	local hash = pedhash
	plygrp =  player.get_player_group(pid)
	local pedp = player.get_player_ped(pid)
	local parachute = 0xfbab5776
	local pos = player.get_player_coords(pid)
    pos.x = pos.x + 10
	pos.y = pos.y + 20
	
    local offset = v3()
	local offset2 = v3()
	local rot = v3()
	-- offset = Self_offsetPos
	local offset_z = math.random(10, 40)
	offset.z = offset_z
    local headtype = math.random(0, 2)


	rot = entity.get_entity_rotation(pedp)
	streaming.request_model(hash)
	while not streaming.has_model_loaded(hash) do
		
		system.wait(10)
	end
    local p = #escort + 1
	print(hash)

    escort[p] = ped.create_ped(26, hash, pos + offset, 0, true, false)
	print(escort[p])		
	entity.set_entity_god_mode(escort[p], true)
	ui.add_blip_for_entity(escort[p])
	ped.set_ped_component_variation(escort[p], 0, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 2, 0, 0, 0)
    ped.set_ped_component_variation(escort[p], 3, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 4, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 0, 2, 2, 0)
	ped.set_ped_component_variation(escort[p], 8, 1, 0, 0)
	
    ped.set_ped_can_switch_weapons(escort[p], true)
    ped.set_ped_combat_attributes(escort[p], 46, true)
    ped.set_ped_combat_attributes(escort[p], 52, true)
    ped.set_ped_combat_attributes(escort[p], 1, true)
    ped.set_ped_combat_attributes(escort[p], 2, true)
    ped.set_ped_combat_attributes(escort[p], 3, false)
    ped.set_ped_combat_range(escort[p], 2)
    ped.set_ped_combat_ability(escort[p], 2)
    ped.set_ped_combat_movement(escort[p], 2)
	ped.set_ped_can_switch_weapons(escort[p], true)
	weapon.give_delayed_weapon_to_ped(escort[p], parachute, 1, 0)
	
	if not attack == true then
	ped.set_ped_combat_attributes(escort[p], 1424, false)
	pedgroup = ped.get_ped_group(escort[p])
	ped.set_ped_as_group_member(escort[p], plygrp)
	pedgroup = ped.get_ped_group(escort[p])
	ped.set_ped_never_leaves_group(escort[p], true)

	else
	end
		streaming.set_model_as_no_longer_needed(hash)	
end

--Spawn Cleanups


--World Cleanup stuff
local cleanup_done = true

globalFeatures.entity_removal = menu.add_feature("World Cleanup", "parent", globalFeatures.cleanup).id

clear_World_ent = menu.add_feature("Fetched World Entities Move & Delete", "action", globalFeatures.entity_removal, function(feat)
	if not cleanup_done == true then return end
	cleanup_done = false
	get_everything()
	system.wait(500)
	clear_world()
	notif("Cleanup complete", "Clean the World", 6)
end)

Force_clear_all = menu.add_feature("Force Removal (Missed Anything?)", "action", globalFeatures.entity_removal, function(feat)
	if not cleanup_done == true then return end
	cleanup_done = false
	force_delete2()
	system.wait(250)
	force_delete2()
end)

local clear_peds = menu.add_feature("Fetch all Peds Move & Delete", "action", globalFeatures.entity_removal, function(feat)
	if not cleanup_done == true then return end
	cleanup_done = false
	get_allpeds()
	system.wait(250)
	move_delete_peds()
	notif("Ped Cleanup complete", "Clean the World", 6)
end)


local fetch_obj = menu.add_feature("Fetch all objects Move & Delete", "action", globalFeatures.entity_removal, function(feat)
	if not cleanup_done == true then return end
	cleanup_done = false
	get_allobj()
	system.wait(250)
	move_delete_obj()
	notif("Object Cleanup complete", "Clean the World", 6)
end)

local fetch_veh = menu.add_feature("Fetch all Vehicles Move & Delete", "action", globalFeatures.entity_removal, function(feat)
	if not cleanup_done == true then return end
	cleanup_done = false
	get_allveh()
	system.wait(250)
	move_delete_veh()
	notif("Vehicle Cleanup complete", "Clean the World", 6)
end)

function get_allpeds()
    allpeds = ped.get_all_peds()
end
function get_allveh()
    allveh = vehicle.get_all_vehicles()
end
function get_allobj()
    allobj = object.get_all_objects()
end
function get_all_pickups()
     allpickups = object.get_all_pickups()
end

function get_everything()
	
	get_all_pickups()
	get_allveh()
	get_allobj()
	get_allpeds()
	object.get_all_pickups()
end

clear_world = function()
    local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270
	
	get_all_pickups()
	get_allveh()
	get_allobj()
	get_allpeds()
	object.get_all_pickups()

    if not (#allpeds) == nil or 0 then
        for i = 1, #allpeds do
            if not ped.is_ped_a_player(allpeds[i]) then
                network.request_control_of_entity(allpeds[i])
                entity.set_entity_coords_no_offset(allpeds[i], pos)
                entity.set_entity_as_no_longer_needed(allpeds[i])
                entity.delete_entity(allpeds[i])
                system.wait(25)
            end
        end
    end
    if not (#allpickups) == nil or 0 then
        for i = 1, #allpickups do
            network.request_control_of_entity(allpickups[i])
            entity.set_entity_coords_no_offset(allpickups[i], pos)
            entity.set_entity_as_no_longer_needed(allpickups[i])
            entity.delete_entity(allpickups[i])
            system.wait(10)
        end
    end
    if not (#allveh) == nil or 0 then
        for i = 1, #allveh do
            network.request_control_of_entity(allveh[i])
            entity.set_entity_coords_no_offset(allveh[i], pos)
            entity.set_entity_as_no_longer_needed(allveh[i])
            entity.delete_entity(allveh[i])
            system.wait(25)
        end
    end
    if not (#allobj) == nil or 0 then
        for i = 1, #allobj do
            network.request_control_of_entity(allobj[i])
            entity.set_entity_coords_no_offset(allobj[i], pos)
            entity.set_entity_as_no_longer_needed(allobj[i])
            entity.delete_entity(allobj[i])
            system.wait(25)
        end
    end
    cleanup_done = true
    return HANDLER_POP
end

force_delete2 = function()
    local pos = v3()
    pos.x = -5784.258301
    pos.y = -8289.385742
    pos.z = -136.411270

    if not (#allpickups) == nil or 0 then
        for i = 1, #allpickups do
            if not entity.is_an_entity(allpickups[i]) then
                return
            end
            network.request_control_of_entity(allpickups[i])
            entity.set_entity_coords_no_offset(allpickups[i], pos)
            entity.set_entity_as_no_longer_needed(allpickups[i])
            entity.delete_entity(allpickups[i])
            system.wait(5)
        end
    end

    if not (#allobj) == nil or 0 then
        for i = 1, #allobj do
            if not entity.is_an_entity(allobj[i]) then
                return
            end
            network.request_control_of_entity(allobj[i])
            entity.set_entity_coords_no_offset(allobj[i], pos)
            entity.set_entity_as_no_longer_needed(allobj[i])
            entity.delete_entity(allobj[i])
            system.wait(10)
        end
    end

    if not (#allveh) == nil or 0 then
        for i = 1, #allveh do
            if not entity.is_an_entity(allveh[i]) then
                return
            end
            network.request_control_of_entity(allveh[i])
            entity.set_entity_coords_no_offset(allveh[i], pos)
            entity.set_entity_as_no_longer_needed(allveh[i])
            entity.delete_entity(allveh[i])
            system.wait(100)
        end
		end

    if not (#allpeds) == nil or 0 then
        for i = 1, #allpeds do
            if not entity.is_an_entity(allpeds[i]) then
                return
            end
            if not ped.is_ped_a_player(allpeds[i]) then
                network.request_control_of_entity(allpeds[i])
                entity.set_entity_coords_no_offset(allpeds[i], pos)
                entity.set_entity_as_no_longer_needed(allpeds[i])
                entity.delete_entity(allpeds[i])
                system.wait(100)
            end
        end
    end
    return HANDLER_POP
end

dump_onplayer = function(pid, pos)
	moist_notify("Ensure you are ~h~ ~r~ NOT!~o~ Spectating Player\n~h~~w~3 Seconds\nUntil ~r~~h~Cunt Dump ~g~~h~Starts" , 204)
	system.wait(3000)
	allpeds = ped.get_all_peds()
		system.wait(200)
	allveh = vehicle.get_all_vehicles()
		system.wait(200)
    allobj = object.get_all_objects()
		system.wait(200)
    allpickups = object.get_all_pickups()
		system.wait(400)

	for i = 1, #allpickups do
		network.request_control_of_entity(allpickups[i])
		entity.set_entity_coords_no_offset(allpickups[i], pos)
		entity.set_entity_as_no_longer_needed(allpickups[i])
		-- entity.delete_entity(allpickups[i])
	end
	system.wait(400)
	for i = 1, #allobj do
		network.request_control_of_entity(allobj[i])
		entity.set_entity_coords_no_offset(allobj[i], pos)
		entity.set_entity_as_no_longer_needed(allobj[i])
		-- entity.delete_entity(allobj[i])
	end
	system.wait(400)
	    for i = 1, #allveh do
			network.request_control_of_entity(allveh[i])
			entity.set_entity_coords_no_offset(allveh[i], pos)
			entity.set_entity_as_no_longer_needed(allveh[i])
			-- entity.delete_entity(allveh[i])
		end
		system.wait(400)
	    for i = 1, #allpeds do
	        if not ped.is_ped_a_player(allpeds[i]) then
				network.request_control_of_entity(allpeds[i])
	            entity.set_entity_coords_no_offset(allpeds[i], pos)
	            entity.set_entity_as_no_longer_needed(allpeds[i])
	            -- entity.delete_entity(allpeds[i])
			end
			system.wait(400)
		end
		moist_notify("World Dumped On That Cunt!\n GG <font size='18'>~ex_r*~ ", 200)
end


local function spawn_veh(pid, vehhash, offdist, mod, modvalue)
	local hash = vehhash
	
    local pos = player.get_player_coords(pid)
	pos.x = pos.x + 10
	pos.y = pos.y + 10
	local offset = v3()
	offset = get_offset(pid, -20)
	
	streaming.request_model(hash)
	while not streaming.has_model_loaded(hash) do
		
		system.wait(10)
	end

    local y = #escortveh + 1
    escortveh[y] = vehicle.create_vehicle(hash, offset, player.get_player_heading(pid), true, false)

	print(escortveh[y])
	vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
	vehicle.get_vehicle_mod(escortveh[y], mod)
	vehicle.set_vehicle_mod(escortveh[y], mod, modvalue, false)
	ui.add_blip_for_entity(escortveh[y])
    vehicle.set_vehicle_on_ground_properly(escortveh[y])
    entity.set_entity_god_mode(escortveh[y], true)
    vehicle.set_vehicle_doors_locked(escortveh[y], 5)
	
    network.request_control_of_entity(escortveh[y])
	streaming.set_model_as_no_longer_needed(hash)

end



ped_cleanup = menu.add_player_feature("Delete Ped Spawns", "action", playerfeatVars.f, function(feat)
	
	if #escort == 0 or nil then return end
	local pos = v3()
				pos.x = presets[1][2]
				pos.y = presets[1][3]
				pos.z = presets[1][4]
				
	for i = 1, #escort do
		
	ped.clear_ped_tasks_immediately(escort[i])
	entity.detach_entity(escort[i])

	entity.set_entity_coords_no_offset(escort[i], pos)

	entity.set_entity_as_no_longer_needed(escort[i])
	entity.delete_entity(escort[i])
	end
end)

pedveh_cleanup = menu.add_player_feature("Delete Ped Spawns + Vehicles", "action", playerfeatVars.f, function(feat)
	if #escort == 0 or nil then return end
	local pos = v3()
				pos.x = presets[1][2]
				pos.y = presets[1][3]
				pos.z = presets[1][4]
				
	for i = 1, #escort do
		
	ped.clear_ped_tasks_immediately(escort[i])


	entity.set_entity_coords_no_offset(escort[i], pos)

	entity.set_entity_as_no_longer_needed(escort[i])
	entity.delete_entity(escort[i])
	end
	if #escortveh == 0 or nil then return end
	for y = 1, #escortveh do
		
	ped.clear_ped_tasks_immediately(escortveh[y])
	entity.detach_entity(escortveh[y])

	entity.set_entity_coords_no_offset(escortveh[y], pos)

	entity.set_entity_as_no_longer_needed(escortveh[y])
	entity.delete_entity(escortveh[y])
	end
	
end)

--OSD Functions


OptionsVar.aim_control = menu.add_feature("Detonate Vehicle Aiming at(DPAD-R)", "toggle", globalFeatures.moistopt, function(feat)
	setting["aimDetonate_control"] = true
		if feat.on then
		if not controls.is_control_pressed(6,54) then
			return HANDLER_CONTINUE
		end
	entity_control = player.get_entity_player_is_aiming_at(player.player_id())
	
	if entity.is_entity_a_ped(entity_control) then
	--ped.clear_ped_tasks_immediately(entity_control)
	if entity.get_entity_god_mode(entity_control) then entity.set_entity_god_mode(entity_control, false)
	end
	if entity.is_entity_attached(entity_control) then
	entity_control = entity.get_entity_attached_to(entity_control)
	end
	end
	if entity.get_entity_god_mode(entity_control) then entity.set_entity_god_mode(entity_control, false)
	end
	if entity.is_entity_a_vehicle(entity_control) then
		network.request_control_of_entity(entity_control)
		vehicle.add_vehicle_phone_explosive_device(entity_control)
	system.wait(25)
	end
	
	network.request_control_of_entity(entity_control)
	if vehicle.has_vehicle_phone_explosive_device() then
	vehicle.detonate_vehicle_phone_explosive_device()
	end
	return HANDLER_CONTINUE
	end
	setting["aimDetonate_control"] = false
	return HANDLER_POP

end)
OptionsVar.aim_control.on = setting["aimDetonate_control"]

PlyTracker.track_all = menu.add_feature("Track all Players POS", "toggle", globalFeatures.moistopt, function(feat)
		setting["PlyTracker.track_all"] = true
		if feat.on then
		
		for i = 0, 32 do
		local y = i + 1
		local offset = v3()

		pos_bool, tracking.playerped_posi[y] = ped.get_ped_bone_coords(player.get_player_ped(i), 31086, offset)
		local ent
		local ent1 = player.get_player_ped(i)	
		local ent2 = ped.get_vehicle_ped_is_using(player.get_player_ped(i))

		if ped.is_ped_in_any_vehicle(ent1) then ent = ent2 else ent = ent1 end
		local speed = entity.get_entity_speed(ent)
		local speedcalc = speed * 3.6 --kmph
		local speedcalc2 =  speed * 2.236936 --mph
		tracking.playerped_speed1[y] = math.ceil(speedcalc)
		tracking.playerped_speed2[y] = math.ceil(speedcalc2)
		tracking.playerped_speed3[y] = speed
		end
		return HANDLER_CONTINUE
		end
		setting["PlyTracker.track_all"] = false
		return HANDLER_POP
end)
PlyTracker.track_all.on = setting["PlyTracker.track_all"]

PlyTracker.track_all_HP = menu.add_feature("Track all Players HP", "toggle", globalFeatures.moistopt, function(feat)
		setting["PlyTracker.track_all_HP"] = true
	if feat.on then
		for i = 0, 32 do
			local y = i + 1

			tracking.HP_tracker1[y] = player.get_player_health(i)
			tracking.HP_tracker2[y] = player.get_player_max_health(i)
			tracking.HP_tracker3[y] = player.get_player_armour(i)
		end
		return HANDLER_CONTINUE
	end
	setting["PlyTracker.track_all_HP"] = false
	return HANDLER_POP

end)
PlyTracker.track_all_HP.on = setting["PlyTracker.track_all_HP"]

OSD.modvehgod_osd = menu.add_feature("Vehicle God OSD", "toggle", globalFeatures.moistopt, function(feat)
		setting["OSD.modvehgod_osd"] = true
		if feat.on then
			local pos = v2()
			pos.x = 0.001
			pos.y = .0255

			for i = 0, 32 do
				pos.x = 0.001
				if player.is_player_vehicle_god(i) then
					ui.set_text_scale(0.235)
					ui.set_text_font(0)
					ui.set_text_color(255, 255, 255, 255)
					ui.set_text_centre(false)
					ui.set_text_outline(true)
					ui.draw_text("vehgod: ", pos)

					pos.x = 0.025

					name = player.get_player_name(i)
					ui.set_text_scale(0.235)
					ui.set_text_font(0)
					ui.set_text_color(255, 255, 0, 255)
					ui.set_text_centre(false)
					ui.set_text_outline(true)
					local Plyname = tostring(player.get_player_name(i))
					ui.draw_text(Plyname, pos)
				end
				pos.y = pos.y + 0.040
			end

			return HANDLER_CONTINUE
		end
		setting["OSD.modvehgod_osd"] = false
		return HANDLER_POP
end)
OSD.modvehgod_osd.on = setting["OSD.modvehgod_osd"]

OSD.modvehspeed_osd = menu.add_feature("Modded Vehicle Speed OSD", "toggle", globalFeatures.moistopt, function(feat)
	setting["OSD.modvehspeed_osd"] = true
		if feat.on then
			local pos = v2()
			pos.x = 0.001
			pos.y = .003

			local name
			for i = 0, 32 do
				if player.get_player_ped(i) ~= 0 then
					pos.x = 0.001

					if tracking.playerped_speed1[i + 1] > 275 then
						name = player.get_player_name(i)
						ui.set_text_scale(0.235)
						ui.set_text_font(0)
						ui.set_text_color(255, 0, 0, 255)
						ui.set_text_centre(false)
						ui.set_text_outline(true)

						ui.draw_text("HighSpeed: ", pos)
						pos.x = 0.035

						ui.set_text_scale(0.235)
						ui.set_text_font(0)
						ui.set_text_color(255, 255, 255, 255)
						ui.set_text_centre(false)
						ui.set_text_outline(true)
						ui.draw_text(name, pos)
						pos.x = 0.089

						ui.set_text_scale(0.235)
						ui.set_text_font(0)
						ui.set_text_color(0, 255, 255, 255)
						ui.set_text_centre(false)
						ui.set_text_outline(true)
						ui.draw_text(" <" .. tracking.playerped_speed1[i + 1] .. ">", pos)

						pos.y = pos.y + 0.040
					end
				end
			end
			return HANDLER_CONTINUE
		end
		setting["OSD.modvehspeed_osd"] = false
		return HANDLER_POP

end)
OSD.modvehspeed_osd.on = setting["OSD.modvehspeed_osd"]

OSD.modspec_osd = menu.add_feature("Spectate OSD", "toggle", globalFeatures.moistopt, function(feat)
			setting["OSD.modspec_osd"] = true
			if feat.on then
			local pos = v2()
			pos.x = 0.01
			pos.y = .03

			for i = 0, 32 do
				if
					player.is_player_spectating(i) and player.is_player_playing(i) and
						interior.get_interior_from_entity(player.get_player_ped(i)) == 0
				 then
					local name = player.get_player_name(i)
					pos.y = pos.y + 0.08
					ui.set_text_scale(0.3)
					ui.set_text_font(0)
					ui.set_text_color(0, 255, 255, 255)
					ui.set_text_centre(false)
					ui.set_text_outline(true)
					ui.draw_text("Modded Spectate: " .. name, pos)
				end
			end
			return HANDLER_CONTINUE
		end
		setting["OSD.modspec_osd"] = false
		return HANDLER_POP

end)
OSD.modspec_osd.on = setting["OSD.modspec_osd"]

OSD.Player_bar = menu.add_feature("Player Bar OSD", "toggle", globalFeatures.moistopt, function(feat)
			setting["OSD.Player_bar"] = true
			if feat.on then
			ui.draw_rect(0.001, 0.990, 2.5, 0.065, 0, 0, 0, 255)
			local pos = v2()

			pos.x = 0.001
			pos.y = .960

			for i = 0, 32 do
				if player.get_player_ped(i) ~= 0 then
					local name = player.get_player_name(i)

					local playercolor = {{255, 255, 255}, {255, 0, 0}, {255, 0, 255}, {0, 255, 255}}
					ui.set_text_color(playercolor[1][1], playercolor[1][2], playercolor[1][3], 255)

					if player.is_player_god(i) then
						ui.set_text_color(playercolor[2][1], playercolor[2][2], playercolor[2][3], 255)
					end
					if player.is_player_god(i) and player.is_player_vehicle_god(i) then
						ui.set_text_color(playercolor[4][1], playercolor[4][2], playercolor[4][3], 255)
					end
					if player.is_player_vehicle_god(i) then
						ui.set_text_color(playercolor[3][1], playercolor[3][2], playercolor[3][3], 255)
					end

					if pos.x > 0.90 then
						pos.y = .970
						pos.x = 0.001
					else
					end
					ui.set_text_scale(0.2)
					ui.set_text_font(0)

					ui.set_text_centre(false)
					ui.set_text_outline(true)

					ui.draw_text("< " .. name .. " >", pos)

					pos.x = pos.x + 0.055
				end
			end

			return HANDLER_CONTINUE
		end
		setting["OSD.Player_bar"] = false
	return HANDLER_POP
end)
OSD.Player_bar.on = setting["OSD.Player_bar"]

OSD.date_time_OSD = menu.add_feature("Date & Time OSD", "toggle", globalFeatures.moistopt, function(feat)
	setting["osd_date_time"] = true
	while feat.on do
	
		local pos = v2()
		
		local d = os.date()
		
		local dtime = string.match(d, "%d%d:%d%d:%d%d")
		
		local dt = os.date("%d/%m/%y%y")
		
		local osd_Cur_Date = (string.format(dt))
		pos.x = .50082
		pos.y = .00000025
		ui.set_text_scale(0.4009)
		ui.set_text_font(5)
		ui.set_text_color(0, 0, 0, 255)
		ui.set_text_centre(1)
		ui.set_text_outline(1)
		ui.draw_text(osd_Cur_Date, pos)
		pos.x = .5
		pos.y = .00000025
		ui.set_text_scale(0.4002)
		ui.set_text_font(5)
		ui.set_text_color(255, 255, 255, 255)
		ui.set_text_centre(1)
		ui.set_text_outline(1)
		ui.draw_text(osd_Cur_Date, pos)
		pos.x = .50085
		pos.y = .02
		
		local d = os.date()
		
		local dtime = string.match(d, "%d%d:%d%d:%d%d")
		
		local dt = os.date("%d/%m/%y%y")
		
		local osd_Cur_Time = (string.format(dtime))
		ui.set_text_scale(0.45)
		ui.set_text_font(0)
		ui.set_text_color(0, 0, 0, 255)
		ui.set_text_centre(1)
		ui.set_text_outline(1)
		ui.draw_text(osd_Cur_Time, pos)
		pos.x = .5
		pos.y = .02
		
		local d = os.date()
		
		local dtime = string.match(d, "%d%d:%d%d:%d%d")
		
		local dt = os.date("%d/%m/%y%y")
		
		local osd_Cur_Time = (string.format(dtime))
		ui.set_text_scale(0.45)
		ui.set_text_font(0)
		ui.set_text_color(255, 255, 255, 255)
		ui.set_text_centre(1)
		ui.set_text_outline(1)
		ui.draw_text(osd_Cur_Time, pos)
		
	return HANDLER_CONTINUE
	end
	setting["osd_date_time"] = false
	return HANDLER_POP
			
end)
OSD.date_time_OSD.on = setting["osd_date_time"]

local function give_weapon()
for i = 1, #ped_wep do
	menu.add_feature("Weapon: " ..ped_wep[i][1], "action", globalFeatures.self_wep, function(feat)
		local pped = player.get_player_ped(player.player_id())
			weapon.give_delayed_weapon_to_ped(pped, ped_wep[i][2], 0, 1)
	end)
end
end
give_weapon()








--TODO: Player Features
function load_spawn_options()
	
for i = 1, #escort_ped do 
 playerFeat1[i] = menu.add_player_feature("Ped: " .. escort_ped[i][1], "parent", playerfeatVars.b, function() 
 model = escort_ped[i][2] 
 end).id

end

for i = 1, #playerFeat1 do
	
	playerFeatParent[#playerFeatParent+1] = menu.add_player_feature("Ped + Weapon", "parent", playerFeat1[i]).id
end

for i = 1, #playerFeat1 do
	playerFeatParent2[#playerFeatParent2+1] = menu.add_player_feature("Ped + Vehicle", "parent", playerFeat1[i]).id
end

for i = 1, #playerFeatParent do
for y = 1, #ped_wep do

	playerFeat2[#playerFeat2+1] = menu.add_player_feature("Wep: " .. ped_wep[y][1], "parent", playerFeatParent[i], function()
	wephash = ped_wep[y][2]

		end).id
end
end

	
for i = 1, #playerFeat2 do
	menu.add_player_feature("Send Attacker via Parachute", "action", playerFeat2[i], function(feat, pid)
			
			local pped = player.get_player_ped(pid)
			
			spawn_ped_v2(pid, model, true)
			
			system.wait(100)
			local i = #escort
			local pos = player.get_player_coords(pid)
			ai.task_parachute_to_target(escort[i], pos)
			
			system.wait(12000)
			weapon.give_delayed_weapon_to_ped(escort[i], wephash, 0, 1)
			
			ai.task_combat_ped(escort[i], pped, 0, 16)
end).threaded = false
end


for i = 1, #playerFeat2 do
	menu.add_player_feature("Spawn Attacker & Task", "action", playerFeat2[i], function(feat, pid)
			
			local pped = player.get_player_ped(pid)
			
			spawn_ped(pid, model, -15, true)
			
			system.wait(100)
			local i = #escort
			entity.set_entity_god_mode(escort[i], true)
			ped.set_ped_combat_attributes(escort[i], 52, true)
			ped.set_ped_combat_attributes(escort[i], 1, true)
			ped.set_ped_combat_attributes(escort[i], 46, true)
			ped.set_ped_combat_attributes(escort[i], 2, true)
			ped.set_ped_combat_range(escort[i], 2)
			ped.set_ped_combat_ability(escort[i], 2)
			ped.set_ped_combat_movement(escort[i], 2)
			weapon.give_delayed_weapon_to_ped(escort[i], wephash, 0, 1)
			ped.set_ped_can_switch_weapons(escort[i], true)
			ai.task_combat_ped(escort[i], pped, 0, 16)
			
			
		end)
end
	
for i = 1, #playerFeat2 do
	menu.add_player_feature("Spawn Support Ped", "action", playerFeat2[i], function(feat, pid)
			
			local pped = player.get_player_ped(pid)
			
			spawn_ped(pid, model, 5, false)
			
			system.wait(100)
			local i = #escort
			entity.set_entity_god_mode(escort[i], true)
			ped.set_ped_combat_attributes(escort[i], 52, true)
			ped.set_ped_combat_attributes(escort[i], 1, true)
			ped.set_ped_combat_attributes(escort[i], 46, true)
			ped.set_ped_combat_attributes(escort[i], 2, true)
			ped.set_ped_combat_range(escort[i], 2)
			ped.set_ped_combat_ability(escort[i], 2)
			ped.set_ped_combat_movement(escort[i], 2)
			weapon.give_delayed_weapon_to_ped(escort[i], wephash, 0, 1)
			ped.set_ped_can_switch_weapons(escort[i], true)
			
end)
end

for i = 1, #playerFeatParent2 do
for y = 1, #veh_list do

		playerFeat3[#playerFeat3+1]  = menu.add_player_feature("Veh: " .. veh_list[y][1], "parent", playerFeatParent2[i], function()
			vehhash = veh_list[y][2]
			if veh_list[y][3] == nil then
				mod = 10
				modvalue = -1
				else
				mod = veh_list[y][3]
				modvalue = veh_list[y][4]
				
			end

		end).id
end
end

for i = 1, #playerFeat3 do
	menu.add_player_feature("Spawn as Escort & Task", "action", playerFeat3[i], function(feat, pid)
			spawn_ped(pid, model, 10, false)
			local groupIDs = {}
			local i = #groupIDs + 1
			groupIDs[i] = ped.create_group()
			local y = #groupIDs + 1
			groupIDs[y] = ped.create_group()
			ped.set_relationship_between_groups(0, groupIDs[i], groupIDs[y])
			ped.set_relationship_between_groups(0, groupIDs[y], groupIDs[i])
			system.wait(100)
			spawn_veh(pid, vehhash, -20, mod, modvalue)
			system.wait(100)
			local p = #escort
			local y = #escortveh
			ped.set_ped_as_group_member(escort[p], groupIDs[i])
			ped.set_ped_never_leaves_group(escort[p], true)

			ped.set_ped_into_vehicle(escort[p], escortveh[y], -1)
			local pped = player.get_player_ped(pid)
			ai.task_vehicle_follow(escort[p], escortveh[y], pped, 250.00, 262144, 25)

			if vehhash == 0x2189D250 then
				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 0)
			end
			if vehhash == 0xF92AEC4D then
				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 3)
			end
			if vehhash == 0xA09E15FD then
				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)
				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
			end
			if vehhash == 0x5BFA5C4B then
				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)

				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
			end
			if vehhash == 0x9114EADA then
				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
			end
			if vehhash == 0x8D4B7A8A then
				spawn_ped(pid, model, 10, false)
				local x = #escort
				ped.set_ped_as_group_member(escort[x], groupIDs[i])
				ped.set_ped_never_leaves_group(escort[x], true)
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
			end

end)
end

for i = 1, #playerFeat3 do
	menu.add_player_feature("Spawn as Attacker & Task", "action", playerFeat3[i], function(feat, pid)
			local pped = player.get_player_ped(pid)
			spawn_ped(pid, model, 10, true)
			system.wait(100)
			spawn_veh(pid, vehhash, -20, mod, modvalue)
			local p = #escort
			local y = #escortveh

			ped.set_ped_into_vehicle(escort[p], escortveh[y], -1)
			ai.task_combat_ped(escort[p], pped, 0, 16)

			if vehhash == 0x2189D250 then
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 0)
				ai.task_combat_ped(escort[x], pped, 0, 16)
			end
			if vehhash == 0xF92AEC4D then
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 3)
				ai.task_combat_ped(escort[x], pped, 0, 16)
			end
			if vehhash == 0xA09E15FD then
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)
				ai.task_combat_ped(escort[x], pped, 0, 16)
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
				ai.task_combat_ped(escort[x], pped, 0, 16)
			end
			if vehhash == 0x5BFA5C4B then
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)
				ai.task_combat_ped(escort[x], pped, 0, 16)
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
				ai.task_combat_ped(escort[x], pped, 0, 16)
			end
			if vehhash == 0x9114EADA then
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
				ai.task_combat_ped(escort[x], pped, 0, 16)
			end
			if vehhash == 0x8D4B7A8A then
				spawn_ped(pid, model, 10, true)
				local x = #escort
				ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
				ai.task_combat_ped(escort[x], pped, 0, 16)
			end

end)
end

end
load_spawn_options()

friendsshown = false

showfriends = menu.add_feature("Show Friends Notify", "toggle", globalFeatures.moistopt, function(feat)
	setting["showfriends"] = true
	
	while feat.on do
		system.wait(1000)
	return HANDLER_CONTINUE
	end
	setting["showfriends"] = false
	friendsshown = false
	return HANDLER_POP
end)
showfriends.on = setting["showfriends"]

menu.add_feature("Any Friends Online?", "action", globalFeatures.parent, function(feat)
    for i=0,network.get_friend_count()-1 do
        
		local friendName = network.get_friend_index_name(i)
        
		local friendScid = network.get_friend_scid(friendName)
        
		local friendOnline = network.is_friend_index_online(i)
        
		local friendMplay = network.is_friend_in_multiplayer(friendName)
        print(string.format("Friend index %s %s (%s) is %s", i, friendName, friendScid, friendOnline and "online" or "offline"))
        if friendOnline then
            if friendMplay then
                ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName .. "~h~~u~\nis Playing Online", "~u~Network ~u~Presence", 172)
				else
                ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName , "~u~Network Presence", 47)
			end
			system.wait(100)
		end
	end
end)


function friendscheck()
    for i=0,network.get_friend_count()-1 do
        
		local friendName = network.get_friend_index_name(i)
        
		local friendScid = network.get_friend_scid(friendName)
        
		local friendOnline = network.is_friend_index_online(i)
        
		local friendMplay = network.is_friend_in_multiplayer(friendName)
        print(string.format("Friend index %s %s (%s) is %s", i, friendName, friendScid, friendOnline and "online" or "offline"))
        if friendOnline then
            if friendMplay then
                ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName .. "~h~~u~\nis Playing Online", "~u~Network ~u~Presence", 172)
				else
                ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName , "~u~Network Presence", 47)
			end
			system.wait(100)
		end
	end
end


--Player list


for pid=0,31 do
	
	
	local featureVars = {}
	local features = {}
		
	featureVars.f = menu.add_feature("Player " .. pid, "parent", playersFeature.id)	
	featureVars.k = menu.add_feature("Remove Player Options", "parent", featureVars.f.id, function()
			if #data == 0 or nil then
				dataload()
			end
			features["Kick1_Type1"].feat.max_i = #data
			features["Kick1_Type2"].feat.max_i = #data
			features["Kick1_Type1"].feat.min_i = 1
			features["Kick1_Type2"].feat.min_i = 1

			if #data2 == 0 or nil then
				dataload2()
			end
			features["Kick2_Type1"].feat.max_i = #data2
			features["Kick2_Type2"].feat.max_i = #data2
			features["Kick2_Type1"].feat.min_i = 1
			features["Kick2_Type2"].feat.min_i = 1
    end)
	
	featureVars.v = menu.add_feature("Vehicle Options", "parent", featureVars.f.id)
	featureVars.t = menu.add_feature("Teleport Options", "parent", featureVars.f.id)	

		
	features["ceo money1"] = {feat = menu.add_feature("CEO 10k money loop", "toggle", featureVars.f.id, function(feat)
		while feat.on do
			print("Money Trigger loop")
			print(os.date())
					
			script.trigger_script_event(-601653676, pid, {player.player_id(), 10000, -1292453789, 1, script.get_global_i(1628237 + (1 + (pid * 615)) + 533), script.get_global_i(1650640 + 9), script.get_global_i(1650640 + 10)})
				system.wait(31000)
			print(os.date())
				return HANDLER_CONTINUE
			end
			print("loop end")

			return HANDLER_POP
	end), type = "toggle", callback = function()
    end}

	features["TeleportPlayernext2me"] = {feat = menu.add_feature("Teleport Next2me (old Version)", "toggle", featureVars.t.id, function(feat)
			if feat.on then
				local plyveh

				local pedd = player.get_player_ped(pid)

				local pos = v3()
				pos = entity.get_entity_coords(player.get_player_ped(player.player_id()))
				pos.x = pos.x + 3
				if ped.is_ped_in_any_vehicle(pedd) then
					plyveh = ped.get_vehicle_ped_is_using(pedd)
					network.request_control_of_entity(plyveh)
					entity.set_entity_coords_no_offset(plyveh, pos)
				--vehicle.set_vehicle_on_ground_properly(plyveh)
				end

				return HANDLER_CONTINUE
			end
			return HANDLER_POP

	end),  type = "toggle", callback = function()
	end}
		
	features["TeleportPlayernext2me"] = {feat = menu.add_feature("Teleport in front of Me", "toggle", featureVars.t.id, function(feat)
			if feat.on then
				local plyveh

				local pedd = player.get_player_ped(pid)
				get_offset(player.player_id(), 5)
				local pos = offsetPos

				if ped.is_ped_in_any_vehicle(pedd) then
					plyveh = ped.get_vehicle_ped_is_using(pedd)
					network.request_control_of_entity(plyveh)
					entity.set_entity_coords_no_offset(plyveh, pos)
				--vehicle.set_vehicle_on_ground_properly(plyveh)
				end

				return HANDLER_CONTINUE
			end
			return HANDLER_POP

	end),  type = "toggle", callback = function()
	end}
		

	features["TeleportPlayerBeyondLimits"] = {feat = menu.add_feature("Teleport Beyond World Limits", "toggle", featureVars.t.id, function(feat)
			if feat.on then
				local plyveh
				local pos = v3()
				pos.x = presets[1][2]
				pos.y = presets[1][3]
				pos.z = presets[1][4]

				local pedd = player.get_player_ped(pid)
				if ped.is_ped_in_any_vehicle(pedd) then
					plyveh = ped.get_vehicle_ped_is_using(pedd)
					network.request_control_of_entity(plyveh)
					entity.set_entity_coords_no_offset(plyveh, pos)
					end
				return HANDLER_CONTINUE
			end
		return HANDLER_POP
	end),  type = "toggle", callback = function()
	end}
		
	features["Teleport Godmode Death"] = {feat = menu.add_feature("Teleport to Death (Ocean Out of World Limits)", "toggle", featureVars.t.id, function(feat)
		if feat.on then
			local plyveh
			local pos = v3()
			pos.x = presets[3][2]
			pos.y = presets[3][3]
			pos.z = presets[3][4]

			local pedd = player.get_player_ped(pid)
			if ped.is_ped_in_any_vehicle(pedd) then
				plyveh = ped.get_vehicle_ped_is_using(pedd)
				network.request_control_of_entity(plyveh)
				entity.set_entity_coords_no_offset(plyveh, pos)
			end
		end
		return HANDLER_CONTINUE

	end),  type = "toggle", callback = function()
	end}
		
	features["Teleport Godmode Death2"] = {feat = menu.add_feature("Teleport to Death (KillBarrier)", "toggle", featureVars.t.id, function(feat)
			if feat.on then
			local plyveh
			local pos = v3()

			pos.x = presets[2][2]
			pos.y = presets[2][3]
			pos.z = presets[2][4]

			local pedd = player.get_player_ped(pid)
			if ped.is_ped_in_any_vehicle(pedd) then
				plyveh = ped.get_vehicle_ped_is_using(pedd)
				network.request_control_of_entity(plyveh)
				entity.set_entity_coords_no_offset(plyveh, pos)
			end
		end
		return HANDLER_CONTINUE

	end),  type = "toggle", callback = function()
	end}
	
	features["Block Passive"] = {feat = menu.add_feature("Block Passive Mode", "action", featureVars.f.id, function(feat)
					script.trigger_script_event(1421531240, pid, {1, 1})
							local scid = player.get_player_scid(pid)
									local name = tostring(player.get_player_name(pid))
										debug_out(string.format("Player: " ..name .." [" ..scid .."]" .."Blocked Passive"))
	end), type = "action"}
		
	features["Unblock Passive"] = {feat = menu.add_feature("Unblock Passive Mode", "action", featureVars.f.id, function(feat)

			 script.trigger_script_event(1421531240, pid, {2, 0})

				scid = player.get_player_scid(pid)
				name = tostring(player.get_player_name(pid))
				debug_out(string.format("Player: " .. name .. " [" .. scid .. "]" .. "Passive Unblocked"))
				
	end), type = "action"}
		

	features["World_Dump"] = {feat = menu.add_feature("Dump World onto this Cunt!", "action", featureVars.f.id, function(feat)
		local pos = v3()
		pos = player.get_player_coords(pid)
		dump_onplayer(pid, pos)
	end), type = "action"}
	
	
	
	
	features["Waypoint"] = {feat = menu.add_feature("Set Waypoint On Player", "toggle", featureVars.f.id, function(feat)
		if feat.on then
			for i=0,31 do
				if i ~= pid and playerFeatures[i].features["Waypoint"].feat then
					playerFeatures[i].features["Waypoint"].feat.on = false
				end
			end
			else
			set_waypoint(nil)
		end
		return HANDLER_POP
	end), type = "toggle", callback = function()
	set_waypoint(player.get_player_coords(pid))
	end}
	features["Waypoint"].feat.threaded = false
	
	playerFeatures[pid] = {feat = featureVars.f, scid = -1, features = features}
	featureVars.f.hidden = true
end

--Main loop
local SessionHost = nil
local ScriptHost = nil
local loopFeat = menu.add_feature("Loop", "toggle", 0, function(feat)
	if feat.on then
		local Online = network.is_session_started()
		if not Online then
			SessionHost = nil
			ScriptHost = nil
		end
		local lpid = player.player_id()
		for pid=0,31 do
			local tbl = playerFeatures[pid]
			local f = tbl.feat
			local scid = player.get_player_scid(pid)
			if scid ~= 4294967295 then
				if f.hidden then f.hidden = false end
				local name = player.get_player_name(pid)
				local isYou = lpid == pid
				local tags = {}
				if Online then
					
					if isYou then
						tags[#tags + 1] = "Y"
					end
					if player.is_player_friend(pid) then
						tags[#tags + 1] = "F"
					end
					if player.is_player_modder(pid, -1) then
						tags[#tags + 1] = "M"
					end
					if player.is_player_host(pid) then
						tags[#tags + 1] = "H"
						if SessionHost ~= pid then
							SessionHost = pid
							notify_above_map("The session host is now " .. (isYou and "you" or name) .. ".")
						end
					end
					if pid == script.get_host_of_this_script() then
						tags[#tags + 1] = "S"
						if ScriptHost ~= pid then
							ScriptHost = pid
							notify_above_map("The script host is now " .. (isYou and "you" or name) .. ".")
						end
					end
					if tbl.scid ~= scid then
						for cf_name,cf in pairs(tbl.features) do
							if cf.type == "toggle" and cf.feat.on then
								cf.feat.on = false
							end
						end
						tbl.scid = scid
						if not isYou then
							--TODO: Modder shit
						end
					end
				end
				if #tags > 0 then
					name = name .. " [" .. table.concat(tags) .. "]"
				end
				if f.name ~= name then f.name = name end
				for cf_name,cf in pairs(tbl.features) do
					if (cf.type ~= "toggle" or cf.feat.on) and cf.callback then
						local status, err = pcall(cf.callback)
						if not status then
							notify_above_map("Error running feature " .. i .. " on pid " .. pid)
							print(err)
						end
					end
				end
				else
				if not f.hidden then
				f.hidden = true
				for cf_name,cf in pairs(tbl.features) do
				if cf.type == "toggle" and cf.feat.on then
				cf.feat.on = false
				end
				end
				end
				end
				end
				return HANDLER_CONTINUE
				end
				return HANDLER_POP
end)
loopFeat.hidden = true
loopFeat.threaded = false
loopFeat.on = true
