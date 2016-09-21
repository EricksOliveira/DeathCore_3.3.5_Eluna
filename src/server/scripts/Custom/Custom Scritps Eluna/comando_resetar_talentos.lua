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
function VIPresetTP(event, player, message, type, language)

	if(message:lower() == "#resetarpt") then
		player:ResetTalents()
		local Tp = (78+(ACCT[player:GetAccountId()].Vip*ACCT["SERVER"].Tp_mod))
		player:SetFreeTalentPoints(Tp, 0)
		player:SetFreeTalentPoints(Tp, 1)
		player:SendBroadcastMessage("|cff00cc00Todos seus pontos de talentos foram resetados!|r")
	else
                end
end
RegisterPlayerEvent(18, VIPresetTP)