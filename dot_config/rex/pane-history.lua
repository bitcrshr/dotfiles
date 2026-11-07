-- Run by launchd: track focus changes from keyboard, mouse, and Rex actions.
local directory = os.getenv("HOME") .. "/.local/state/rex-pane-history/"
local history = {}
local function observe(session_id)
  local view = rex.session.view{ session_id = session_id }
  if not view then return end
  for _, window in ipairs(view.windows or {}) do
    local id, current = window.window_id, window.focused_block_id
    if id and current then
      local old = history[id]
      if not old or old.current ~= current then
        local previous = old and old.current or ""
        history[id] = { current = current, previous = previous }
        local path = directory .. id
        local file = assert(io.open(path .. ".tmp", "w"))
        file:write(current, "\n", previous, "\n")
        file:close()
        assert(os.rename(path .. ".tmp", path))
      end
    end
  end
end

rex.on("session_view_changed", function(ctx) observe(ctx.session_id) end)
rex.on("window_closed", function(_, ev)
  history[ev.window_id] = nil
  os.remove(directory .. ev.window_id)
end)
local result = assert(rex.call("session.list"))
for _, session in ipairs(result.sessions or {}) do observe(session.session_id) end
