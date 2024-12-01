include( "shared.lua" )
include("config/config.lua")
include("core/cl_jobs.lua")
include("libs/logger.lua")
include("core/sh_playerclass.lua")

concommand.Add("switch_team", function( ply, cmd, args )
    print("Args: " .. unpack(args))
end)

RP.print("client side ready...")