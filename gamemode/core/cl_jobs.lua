concommand.Add("get_team", function(ply)
    RP.print(team.GetName(ply:Team()))
end)