--
-- Copyright (C) 2013-2016 DeathCore <http://www.noffearrdeathproject.net/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

-- Functions
local ChatPrefix = "#chat";
local WorldChannelName = "Mundo";
local CooldownTimer = 3; -- Cooldown in seconds. Set to 0 for no CD obviously.
 
local Class = { -- Class colors :) Prettier and easier than the elseif crap :) THESE ARE HEX COLORS!
    [1] = "C79C6E|TInterface\\icons\\INV_Sword_27.png:15|t", -- Warrior
    [2] = "F58CBA|TInterface\\icons\\INV_Hammer_01.png:15|t", -- Paladin
    [3] = "ABD473|TInterface\\icons\\INV_Weapon_Bow_07.png:15|t", -- Hunter
    [4] = "FFF569|TInterface\\icons\\INV_ThrowingKnife_04.png:15|t", -- Rogue
    [5] = "FFFFFF|TInterface\\icons\\INV_Staff_30.png:15|t", -- Priest
    [6] = "C41F3B|TInterface\\icons\\Spell_Deathknight_ClassIcon.png:15|t", -- Death Knight
    [7] = "0070DE|TInterface\\icons\\inv_jewelry_talisman_04.png:15|t", -- Shaman
    [8] = "69CCF0|TInterface\\icons\\INV_Staff_13.png:15|t", -- Mage
    [9] = "9482C9|TInterface\\ICONS/Spell_Nature_FaerieFire.png:15|t", -- Warlock
    [11] = "FF7d0A|TInterface\\icons\\Ability_Druid_Maul.png:15|t" -- Druid
};
 
local Rank = {
    [0] = "7DFF00[", -- Player
   [1] = "E700B1[MOD|cff7DFF00] [|cffE700B1", -- Moderator
   [2] = "E7A200[GM|cff7DFF00] [|cffE7A200", -- Game Master
   [3] = "E7A200[ADMIN|cff7DFF00] [|cffE7A200", -- Admin
   [4] = "E7A200[OWNER|cff7DFF00] [|cffE7A200", -- Console
};
 
-- Do not edit below unless you know what you're doing :)
if (ChatPrefix:sub(-1) ~= " ") then
    ChatPrefix = ChatPrefix.." ";
end
 
local RCD = {};
function ChatSystem(event, player, msg, _, lang)
    if (RCD[player:GetGUIDLow()] == nil) then
        RCD[player:GetGUIDLow()] = 0;
    end

    if (msg:sub(1, ChatPrefix:len()) == ChatPrefix) then
        local r = RCD[player:GetGUIDLow()] - os.clock();
        if (0 < r) then
            local s = string.format("|cFFFF0000Voce precisa esperar %i segundo(s) para falar no #chat!|r", math.floor(r));
            player:SendAreaTriggerMessage(s);
        else
            RCD[player:GetGUIDLow()] = os.clock() + CooldownTimer;
            local t = table.concat({"|cff000000 [", WorldChannelName, "] |cff", Rank[player:GetGMRank()] or Rank[0], "|Hplayer:", player:GetName(), "|h", player:GetName(), "|h|r|cff7DFF00]: |r|cff", Class[player:GetClass()], msg:sub(ChatPrefix:len()+1), "|r"});
            SendWorldMessage(t);
        end
        return false;
    end
end
 
RegisterPlayerEvent(18, ChatSystem);
RegisterPlayerEvent(4, function(_, player) RCD[player:GetGUIDLow()] = 0; end);