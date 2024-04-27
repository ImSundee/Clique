--[[-------------------------------------------------------------------------
-- Blizzard_Cata.lua
--
-- This file contains the definitions of the blizzard frame integration
-- options. These settings will not apply until the user interface is
-- reloaded.
--
-- Events registered:
--   * ADDON_LOADED - To watch for loading of the ArenaUI
-------------------------------------------------------------------------]]--

local addonName, addon = ...
local L = addon.L

-- Only load if this is Cata
if not addon:ProjectIsCata() then
    return
end

addon:Printf("Loading Blizzard_cata integration")

function addon:IntegrateBlizzardFrames()
    self:Cata_BlizzSelfFrames()

    self:Cata_BlizzCompactUnitFrames()
    self:Cata_BlizzPartyFrames()
    self:Cata_BlizzBossFrames()
end

function addon:Cata_BlizzCompactUnitFrames()
    if not addon.settings.blizzframes.compactraid then
        return
    end

    hooksecurefunc("CompactUnitFrame_SetUpFrame", function(frame, ...)
        for i = 1, 3 do
            local buffFrame = frame.BuffFrame

            if buffFrame then
                addon:RegisterBlizzardFrame(buffFrame)
            end
        end

        addon:RegisterBlizzardFrame(frame)
    end)
end

function addon:Cata_BlizzSelfFrames()
    local frames = {
        "PlayerFrame",
        "PetFrame",
        "TargetFrame",
        "TargetFrameToT",
    }

    -- Add focus frames for Cata
    table.insert(frames, "FocusFrame")
    table.insert(frames, "FocusFrameToT")
    
    for idx, frame in ipairs(frames) do
        if addon.settings.blizzframes[frame] then
            addon:RegisterBlizzardFrame(frame)
        end
    end
end

function addon:Cata_BlizzPartyFrames()
    if not addon.settings.blizzframes.party then
        return
    end

    local frames = {
        "PartyMemberFrame1",
		"PartyMemberFrame2",
		"PartyMemberFrame3",
		"PartyMemberFrame4",
        --"PartyMemberFrame5",
		"PartyMemberFrame1PetFrame",
		"PartyMemberFrame2PetFrame",
		"PartyMemberFrame3PetFrame",
        "PartyMemberFrame4PetFrame",
        --"PartyMemberFrame5PetFrame",
    }
    for idx, frame in ipairs(frames) do
        addon:RegisterBlizzardFrame(frame)
    end
end


function addon:Cata_BlizzBossFrames()
    if not addon.settings.blizzframes.boss then
        return
    end

    local frames = {
        "Boss1TargetFrame",
        "Boss2TargetFrame",
        "Boss3TargetFrame",
        "Boss4TargetFrame",
    }
    for idx, frame in ipairs(frames) do
        addon:RegisterBlizzardFrame(frame)
    end
end
