rp.print('Processing..', 'roleplay/jobs ~ #', nil, 'warn')

math.randomseed(os.clock())

local indexnum = 0
rp.Jobs = rp.Jobs or {}

function rp.Util.AddJob(name, jobData)
    indexnum = indexnum + 1
    jobData.index = indexnum
    jobData.Name = type(name) == 'string' and name or 'UNKNOWN'
    team.SetUp(indexnum, name, IsColor(jobData.Color) and jobData.Color or Color(255,255,255))

    -- Прекэшируем модели
    if type(jobData.models) ~= 'table' and type(jobData.models) ~= 'string' then
        rp.assert(!rp.configurationWarning, "Excepted \"models (table | string)\" in ".. jobData.Name ..", replaced with placeholder (\"models/player/barney.mdl\")") 
    end
    jobData.models = jobData.models or "models/player/barney.mdl"
    if istable(models) then
        for k, v in pairs(models) do
            util.PrecacheModel(v)
        end
    elseif isstring(models) then
        util.PrecacheModel(models)
    end

    -- Сохраняем работу
    rp.Jobs[indexnum] = jobData
    return indexnum
end


function rp.Util.FindJob(index)
	return rp.Jobs[index] or false
end

function rp.Util.FindJobByID(strID)
	local num = #rp.Jobs
	for i = 1, num do
		local job = rp.Jobs[i]
		if job.jobID == strID then
			return job
		end
	end
end


local pMeta = FindMetaTable("Player")
function pMeta:getJobTable()
	return rp.Jobs[self:Team()] or {}
end

function GM:PlayerSpawn(ply)
    player_manager.SetPlayerClass( ply, "player_rp" )

    if ply:Team() == 1001 then
        ply:SetTeam(rp.DefaultJob)
        ply:Spawn()
    end

    local jobTable = ply:getJobTable()

    -- Player Spawn hook
    if type(jobTable.PlayerSpawn) == 'function' then
        jobTable.PlayerSpawn(ply)
    else
        rp.assert(!rp.configurationWarning, "Excepted \"PlayerSpawn (function)\" in " .. team.GetName(ply:Team()) ..", did u forgot about it?\n Solution: Add \"PlayerSpawn (function)\" in job parameters.")
    end

    -- Player Set Model
    if not jobTable.models then
        rp.assert(!rp.configurationWarning, "Excepted \"models (table | string)\" in ".. team.GetName(ply:Team()) ..", replaced with placeholder (\"models/player/barney.mdl\")") 
        jobTable.models = "models/player/barney.mdl"
    end

    ply:SetModel(type(jobTable.models) == 'table' and table.Random(jobTable.models) or jobTable.models)
    -- if table then random from table else string

    ply:SetupHands()

    rp.PlayerLoadout(ply)
end

function rp.PlayerLoadout(ply)
    local jobTable = ply:getJobTable()

    -- Player LoadOut
    local function loadout(tbl)
        for _, v in pairs(tbl) do -- dictionary = pairs
            ply:Give(v)
        end

        for _, v in ipairs(tbl) do -- array = ipairs
            ply:Give(v)
        end
    end

    loadout(rp.defaultWeapons)

    if type(jobTable.weapons) == 'table' then
        loadout(jobTable.weapons)
    end

    return true
end

rp.print('Processed', 'roleplay/jobs ~ #', nil, 'warn')