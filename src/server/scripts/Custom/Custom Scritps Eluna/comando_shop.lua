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
print("Shop teleporte iniciado!")

local function OnCommand(event, player, command, lang)
      if (player and command == "shop") then
       if (player:IsInCombat() == true) then
        player:SendBroadcastMessage("|cffffff00[ |cffff0000! |cffffff00] |r |cffffffffVoce esta em combate |cffffff00[ |cffff0000! |cffffff00] |r")
   else
    if (player:IsHorde() == true) then
        player:Teleport( 1, 1438.910034, -4421.930176, 25.463301, 0.113060 ) 
    else
        player:Teleport( 0, -8919.160156, 548.473022, 94.119797, 0.647108 ) 
  end
 end
    end
end

RegisterPlayerEvent(42, OnCommand)