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
print("Iniciado tele pve ")

local function OnCommand(event, player, command, lang)
      if (player and command == "pve") then
       if (player:IsInCombat() == true) then
        player:SendBroadcastMessage("|cffffff00[ |cffff0000! |cffffff00] |r |cffffffffVoce esta em combate |cffffff00[ |cffff0000! |cffffff00] |r")
   else
        player:Teleport( 1, -4347.069824, 2310.560059, 7.181640, 1.592000 )
 end
    end
end

RegisterPlayerEvent(42, OnCommand)