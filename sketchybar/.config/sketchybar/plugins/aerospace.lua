#!/usr/bin/env lua

-- Arguments: $1 (workspace ID, e.g., 1, 2)
-- Environment variables: FOCUSED_WORKSPACE, PREV_WORKSPACE, NAME (e.g., space.1)
local workspace_id = arg[1]
local focused_workspace = os.getenv("FOCUSED_WORKSPACE") or ""
local prev_workspace = os.getenv("PREV_WORKSPACE") or ""
local name = os.getenv("NAME") or ""

-- Highlight the focused workspace
if workspace_id == focused_workspace then
	os.execute(
		string.format(
			'sketchybar --set "%s" background.drawing=on background.color=0xff89b4fa label.color=0xff1e1e2e',
			name
		)
	)
else
	os.execute(
		string.format(
			'sketchybar --set "%s" background.drawing=off background.color=0x44ffffff label.color=0xffffffff',
			name
		)
	)
end

-- Remove previous workspace if it’s empty and not focused
if prev_workspace ~= "" and prev_workspace ~= focused_workspace then
	-- Get workspaces with windows
	local handle = io.popen("aerospace list-windows --all --format '%{workspace}' | sort -u")
	local active_workspaces = {}
	for line in handle:lines() do
		active_workspaces[line] = true
	end
	handle:close()

	-- Remove previous workspace if it has no windows
	if not active_workspaces[prev_workspace] then
		os.execute(string.format('sketchybar --remove "space.%s"', prev_workspace))
	end
end
