GM.Version = "1.0"
GM.Name = "RolePlay"
GM.Author = "everyofflineuser & NS Team"

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass
RP = RP or {}
RP.Util = RP.Util or {}

function GM:Initialize()
	RP.print("shared side ready...")
end