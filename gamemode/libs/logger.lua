if not RP then return end

function RP.print(text, prefix, color)
    if not IsColor(color) then color = RP.styleColor end
    if not prefix then prefix = RP.prefix end
    if CLIENT then MsgC(color, prefix .. " " .. text .. "\n")
    elseif SERVER then
        print(prefix .. " " .. text)
    end
end
