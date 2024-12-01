TEAM_CITIZEN = rp.Util.AddJob('Я гражданский Я гражданский', {
	Color = Color(20, 150, 20, 255),
	jobID = 'citizen',
	salary = 10,
    PlayerSpawn = function(ply)
		ply:SetArmor(100)
	end
})

TEAM_FURRY = rp.Util.AddJob('Забанен', { -- Тайм, нахуя? Только больше нарушать будут
	Color = Color(2, 2, 8, 255),
	jobID = 'banned',
	salary = 0,
    PlayerSpawn = function(ply)
		ply:GodEnable()
		ply:SetColor(0,0,0,0) -- пиздец
	end
})


rp.DefaultJob = TEAM_CITIZEN