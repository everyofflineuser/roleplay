RP.print("Jobs initializing...")

local indexnum = 0
RP.Jobs = RP.Jobs or {}

function RP.Util.AddJob(name, jobData)
    indexnum = indexnum + 1
    jobData.index = indexnum
    jobData.Name = name or 'UNKNOWN'
    team.SetUp(indexnum, name, jobData.Color or Color(255,255,255))

    -- Прекэшируем модели
    jobData.WorldModels = jobData.WorldModels or "models/player/barney.mdl"
    if istable(models) then
        for k, v in pairs(models) do
            util.PrecacheModel(v)
        end
    elseif isstring(models) then
        util.PrecacheModel(models)
    end

    -- Сохраняем работу
    RP.Jobs[indexnum] = jobData
    return indexnum
end


function RP.Util.FindJob(index)
	return RP.Jobs[index] or false
end

function RP.Util.FindJobByID(strID)
	local num = #RP.Jobs
	for i = 1, num do
		local job = RP.Jobs[i]
		if job.jobID == strID then
			return job
		end
	end
end


local pMeta = FindMetaTable("Player")
function pMeta:getJobTable()
	return RP.Jobs[self:Team()] or {}
end

function GM:PlayerSpawn(ply)
    player_manager.SetPlayerClass( ply, "player_rp" )

    if ply:Team() == 1001 then
        ply:SetTeam(RP.DefaultJob)
        ply:Spawn()
    end

    local jobTable = ply:getJobTable()

    -- Player Spawn hook
    if type(jobTable.PlayerSpawn) == 'function' then
        jobTable.PlayerSpawn(ply)
    else
        RP.print("Invalid func in PlayerSpawn on " .. team.GetName(ply:Team()))
    end

    -- Player Set Model
    ply:SetModel(jobTable.WorldModels)

    ply:SetupHands()

    RP.PlayerLoadout(ply)
end

function RP.PlayerLoadout(ply)
    local jobTable = ply:getJobTable()

    -- Player LoadOut
    for _, v in pairs(RP.defaultWeapons) do
        ply:Give(v)
    end

    if jobTable.weapons then
        for _, v in pairs(jobTable.weapons) do
            ply:Give(v)
        end
    end

    return true
end

RP.print("Jobs initialized!")