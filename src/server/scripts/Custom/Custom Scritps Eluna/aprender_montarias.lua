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
local RidingLevels = {
[20] = 33389, --Apprentice
[40] = 33392, --Journeyman
[60] = 34092, --Expert
[70] = 34093, --Artisan
[80] = 54197, --Cold Weather
}
 
local Mounts = {
        ["Human"] = {
        [20] = 5655,
        [40] = 18776,
        [60] = 44235,
        [70] = 54860,
        },
        ["Dwarf"] = {
        [20] = 5864,
        [40] = 46748,
        [60] = 44235,
        [70] = 54860,
        },
        ["Night Elf"] = {
        [20] = 8631,
        [40] = 18902,
        [60] = 44235,
        [70] = 54860,
        },
        ["Gnome"] = {
        [20] = 8563,
        [40] = 18774,
        [60] = 44235,
        [70] = 54860,
        },
        ["Draenei"] = {
        [20] = 29743,
        [40] = 29747,
        [60] = 44235,
        [70] = 54860,
        },
        ["Orc"] = {
        [20] = 5665,
        [40] = 18797,
        [60] = 44234,
        [70] = 54860,
        },
        ["Undead"] = {
        [20] = 46308,
        [40] = 47101,
        [60] = 44234,
        [70] = 54860,
        },
        ["Tauren"] = {
        [20] = 46100,
        [40] = 18793,
        [60] = 44234,
        [70] = 54860,
        },
        ["Troll"] = {
        [20] = 8591,
        [40] = 18789,
        [60] = 44234,
        [70] = 54860,
        },
        ["Blood Elf"] = {
        [20] = 29221,
        [40] = 28936,
        [60] = 44234,
        [70] = 54860,
        },
}
 
local function getRiding(event, player)
        local plrLvl = player:GetLevel();
        local plrRace = player:GetRaceAsString(0);
        if RidingLevels[plrLvl] ~= nil then
                player:LearnSpell(RidingLevels[plrLvl]);
                        if not(player:AddItem(Mounts[plrRace][plrLvl])) then --If bags full then send mount in mail.
                                SendMail("Level "..plrLvl.." Montaria", "Seu inventário estava cheio quando chegou ao "..plrLvl..". Agora pega a sua montaria! Equipe DeathCore!", player:GetGUIDLow(), 0, 61, 0, 0, 0, (Mounts[plrRace][plrLvl]), 1);
                                player:SendBroadcastMessage("Uma montaria foi enviada por e-mail (In Game). Por favor relogue para pegar a recompensa."); --Mounts weren't comming through until player relogged.
                       
                        end    
        end
end
 
RegisterPlayerEvent(13,getRiding) --Upon Character Change level run getRiding function