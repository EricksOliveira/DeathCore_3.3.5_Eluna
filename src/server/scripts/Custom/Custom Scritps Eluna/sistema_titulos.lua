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
local T = {
{1, 15, 10}, -- Private/Scout
{2, 16, 20}, -- Corporal/Grunt
{3, 17, 50}, -- Sergeant
{4, 18, 100}, -- Master/Senior Sergeant
{5, 19, 150}, -- Sergeant Major/First Sergeant
{6, 20, 200}, -- Knight/Stone Guard
{7, 21, 250}, -- Knight-Lieutenant/Blood Guard
{8, 22, 300}, -- Knight-Captain/Legionnaire
{9, 23, 350}, -- Knight-Champion/Centurion
{10, 24, 400}, -- Lieutenant Commander/Champion
{11, 25, 1000}, -- Commander/Lieutenant General
{12, 26, 1200}, -- Marshal/General
{13, 27, 1400}, -- Field Marshal/Warlord
{14, 28, 1600}, -- Grand Marshal/High Warlord
{62, 62, 3000}; -- Warbringer
};
 
function OnKilledTarget(event, plr, victim)
        for i = #T, 1, -1 do
                if (plr:GetLifetimeKills() >= T[i][3]) then
                        if not plr:HasTitle(T[i][plr:GetTeam()+1]) then
                                plr:SetKnownTitle(T[i][plr:GetTeam()+1])
                        end
                        break;
                end
        end
end
 
RegisterPlayerEvent(6, OnKilledTarget)