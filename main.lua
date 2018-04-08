local suppository_mod = RegisterMod("suppository", 1)
local suppositoryTrinket = Isaac.GetTrinketIdByName("Suppository")
local shouldUseSuppository = false


function suppository_mod:curseEval(Curses)
	local player = Isaac.GetPlayer(0)

	if player:HasTrinket(suppositoryTrinket) then
		local level = Game():GetLevel()
		local curses = level:GetCurses()

		if (curses > 0) then
			shouldUseSuppository = true
		end
	end
end

function suppository_mod:useSuppository()
	if(shouldUseSuppository) then
		local player = Isaac.GetPlayer(0)
		local level = Game():GetLevel()

		level:RemoveCurses()
		player:TryRemoveTrinket(suppositoryTrinket)
		player:AnimateHappy()

		shouldUseSuppository = false
	end
end

suppository_mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, suppository_mod.curseEval)
suppository_mod:AddCallback(ModCallbacks.MC_POST_UPDATE, suppository_mod.useSuppository)