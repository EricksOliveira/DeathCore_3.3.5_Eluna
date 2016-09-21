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
print "Iniciado primeiro login script"

local Team = {
	[0] = "Alliance",
	[1] = "Horde"
};
local Races = {
	[1] = "um Human",
	[2] = "um Orc",
	[3] = "um Dwarf",
	[4] = "um Night Elf",
	[5] = "um Undead",
	[6] = "um Tauren",
	[7] = "um Gnome",
	[8] = "um Troll",
	[10] = "um Blood Elf",
	[11] = "um Draenei"
};
local Classes = {
        [1] = "C79C6E", 
        [2] = "F58CBA",
        [3] = "ABD473",
        [4] = "FFF569",
        [5] = "FFFFFF",
        [6] = "C41F3B",
        [7] = "0070DE",
        [8] = "69CCF0",
        [9] = "9482C9",
        [11] = "FF7d0A"
};	

function FirstLogin (event, player)
SendWorldMessage("Ola! Eu sou "..player:GetName()..", "..Races[player:GetRace()].." |cFF"..Classes[player:GetClass()]..""..player:GetClassAsString().."|r da "..Team[player:GetTeam()].." . Este e meu novo personagem. Obrigado!.");
end

RegisterPlayerEvent(30, FirstLogin)