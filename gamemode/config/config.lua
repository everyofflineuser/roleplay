
-- rp.styleColor = Color of messages aka. prints: info, warning, error.
rp.styleColor = {
    info = Color(102, 230, 255),
    warning = Color(255, 181, 102),
    ['error']  = Color(255, 102, 102)
}

-- rp.prefix = Default messages prefix.
rp.prefix = "roleplay ~ #"

-- rp.defaultWeapons = Default weapons which will be given after player spawn.
rp.defaultWeapons = {
    "weapon_physcannon",
    "weapon_physgun",
    "gmod_tool"
}

-- rp.showWarns = Should gamemode say if your configuration dont have some critical options, example below:

--[[

    Job configuration:
        TEAM_CITIZEN = rp.Util.AddJob('Citizen', {
	        Color = Color(20, 150, 20, 255),
	        jobID = 'citizen',
	        salary = 10,
        })
    -- In console you will se these messages:
    # Excepted "models (table | string)" in Citizen, replaced with placeholder ("models/player/barney.mdl")
        -- ^ Because job configuration does not have "models" option.

    # Excepted "PlayerSpawn (function)" in Citizen, did u forgot about it?
    ^^ # Solution: Add "PlayerSpawn (function)" in job parameters.
    -- ^ Because job configuration does not have "PlayerSpawn" option.

    true = Enable this warnings.
    false = Disable this warnings
]]

rp.configurationWarning = true