concommand.Add("get_team", function(ply)
    rp.print(team.GetName(ply:Team()))
end)