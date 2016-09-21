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
local function OnCommand(event, player, msg, Type, lang)
  if (msg == "buff") then
    if (player:IsInCombat() == neutre) then
        player:SendAreaTriggerMessage("Voce esta em combate")
  else
        player:AddAura(48162, player) 
        player:AddAura(48074, player) 
        player:AddAura(48170, player) 
        player:AddAura(43223, player) 
        player:AddAura(36880, player) 
        player:AddAura(467, player) 
        player:AddAura(26035, player)
        player:AddAura(69559, player)
        player:AddAura(53758, player)
        player:AddAura(24425, player)
        player:AddAura(30562, player)
        player:AddAura(35076, player)
        player:AddAura(26393, player)
        player:AddAura(30567, player)
        player:AddAura(30557, player)
        player:AddAura(23735, player)
        player:AddAura(23736, player)
        player:AddAura(23737, player)
        player:AddAura(23738, player)
        player:AddAura(23766, player)
        player:AddAura(23767, player)
        player:AddAura(23768, player)
        player:AddAura(23769, player)
        player:AddAura(35874, player)
        player:AddAura(35912, player)
        player:AddAura(38734, player)	
        player:SendNotification("|cffffffff Parabens, agora esta mais forte!!! Divirta-se")
        return false
            end
      end
end

RegisterPlayerEvent(42, OnCommand)