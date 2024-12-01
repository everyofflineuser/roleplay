GM.Version = "1.0"
GM.Name = "RolePlay"
GM.Author = "everyofflineuser & NS Team"

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass
rp = rp or {}
rp.Util = rp.Util or {}

function GM:Initialize()
    -- chto-to
end

MsgC(Color(161, 3, 252), [[
----------------------------------
 ______         __         ______ __              
|   __ \.-----.|  |.-----.|   __ \  |.---.-.--.--.
|      <|  _  ||  ||  -__||    __/  ||  _  |  |  |
|___|__||_____||__||_____||___|  |__||___._|___  |
                                           |_____|
----------------------------------

]])

rp.styleColor = {
    info = Color(102, 230, 255),
    warning = Color(255, 181, 102),
    ['error']  = Color(255, 102, 102)
}
rp.prefix = "roleplay ~ #"

function rp.print(text, prefix, color, _type)
    color = IsColor(color) and color or rp.styleColor.info
    prefix = type(prefix) == 'string' and prefix or rp.prefix
    if not type(text) == 'nil' then _type = 'error' end
    color = type(_type) ~= nil and rp.styleColor[_type] or color
    
    local function print_table(tbl, en)
        local function send(i, v)
            if type(v) == 'table' then print_table(v, en + 1) else rp.print(string.rep('    ', en)..'["'..tostring(i)..'"] = "'..tostring(v)..'"', 'tbl ~ ', Color(255, 111, 0)) end
        end

        for i,v in ipairs(tbl) do
            send(i, v)
        end

        for i,v in pairs(tbl) do
            send(i, v)
        end

        return true
    end

    if type(text) == 'table' then return print_table(text, 0) end

    local source = debug.getinfo(2, 'Sln') 

    text = text or source.currentline ..' line of '.. source.short_src ..': Did you forgot about "string"? \n  Excepted first parameter (text)'
    
    MsgC(color, prefix ..' ')
    MsgC(Color(255, 255, 255), text ..'\n')
    
    return true
end

function rp.error(text, prefix)
    rp.print(text, prefix, nil, 'error')
end

function rp.warn(text, prefix)
    rp.print(text, prefix, nil, 'warning')
end

function rp.assert(exception, text, prefix, color, _type)
    if not exception then rp.print(text, prefix, color, _type) end
end

local loader = {
    loaded = {},

    client = function(self, path)
        rp.print('Loaded to client: '.. path, nil, Color(161, 3, 252))
        if CLIENT then include(path) end
        if SERVER then AddCSLuaFile(path) end
    end,

    server = function(self, path)
        if SERVER then rp.print('Loaded to server: '.. path, nil, Color(161, 3, 252)) include(path) end
    end,

    shared = function(self, path)
        if self.loaded[path] then return end
        rp.print('Loaded to shared: '.. path, nil, Color(161, 3, 252))
        self:server(path)
        self:client(path)
        self.loaded[path] = true
    end,

    dir = function(self, path)
        path = GM.FolderName..'/gamemode/'..path 

        local files = file.Find(path .. '/*', 'LUA')

        for _, script in ipairs(files) do
            local side = string.sub(script, 1, 3)
            local fp = path .. '/' .. script
            if self.loaded[fp] then continue end

            if side ~= 'cl_' and side ~= 'sv_' then
                self:shared(fp)
            elseif side == 'cl_' then
                self:client(fp)
            elseif side == 'sv_' then
                self:server(fp)
            end

            self.loaded[fp] = true
        end

        rp.print('Loaded path: "' .. path .. '"', nil, Color(161, 3, 252))
    end
}

--[[
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile("config/config.lua")
AddCSLuaFile("libs/logger.lua")
AddCSLuaFile("core/cl_jobs.lua")
AddCSLuaFile("core/sh_playerclass.lua")

include( "shared.lua" )
include("config/config.lua")
include("libs/logger.lua")
include("core/sv_jobs.lua")
include("config/jobs.lua")
include("core/sh_playerclass.lua")

rp.print("ServerSide: Ready")
]]

loader:shared(GM.FolderName..'/gamemode/config/config.lua')
loader:dir('core')
loader:dir('core/jobs')
loader:dir('config')
loader:dir('libs')

MsgC(Color(161, 3, 252), '----------------------------------\n')