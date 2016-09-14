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
local function PvPAnnouncer(event, killer, killed)
    SendWorldMessage("[|cFFFF0000PVP Announcer] |Hplayer:"..killer:GetName().."|h |cffE7A200["..killer:GetName().."]|h |cFFFF0000Matou |Hplayer:"..killed:GetName().."|h |cffE7A200["..killed:GetName().."]|h")
end

RegisterPlayerEvent(6, PvPAnnouncer)