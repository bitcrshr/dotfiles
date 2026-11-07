-- Tmux-style bindings. Press Ctrl+Space, release, then the command key.
-- Rex tabs correspond to tmux windows. Native Cmd shortcuts remain available.
local prefix = "ctrl+space>"
local function bind(key, action, args)
  rex.bind(prefix .. key, action, args)
end

bind("c", "client.tab.new")
bind("n", "client.tab.next")
bind("p", "client.tab.previous")
-- Match default tmux numbering: 0 selects the first window, 9 the tenth.
-- Rex's tab indices start at 1.
for number = 0, 9 do
  bind(tostring(number), "client.tab.goto", { index = number + 1 })
end
bind("s", "session.switch")
rex.bind("ctrl+k", "com.superlogical.terminal.clear")

-- Persistent scratch shell per tab, rediscovered after a config reload.
rex.action{
  name = "toggle_scratch",
  title = "Toggle Floating Terminal",
  run = function(ctx)
    local view = assert(rex.session.view{})
    for _, window in ipairs(view.windows or {}) do
      if window.window_id == view.active_window_id then
        for _, layer in ipairs(window.layers or {}) do
          if layer.kind == "floating" then
            for _, block in ipairs(layer.blocks or {}) do
              if block.label == "rex-scratch" then
                local hide = layer.state ~= "minimized" and window.focused_block_id == block.block_id
                return assert(rex.session.set_layer_state{
                  layer_id = layer.layer_id,
                  state = hide and "minimized" or "normal",
                  focus = not hide,
                })
              end
            end
          end
        end
        local process = rex.block.call("com.superlogical.terminal", "process", {})
        local cwd = process and ((process.foreground and process.foreground.cwd)
          or (process.child and process.child.cwd) or process.home)
        return assert(rex.session.new_layer{
          window_id = window.window_id,
          bounds = { 0.15, 0.15, 0.7, 0.7 },
          focus = true,
          layout = { block = {
            flavor = "com.superlogical.terminal.shell",
            label = "rex-scratch",
            options = { cwd = cwd or os.getenv("HOME") },
          } },
        })
      end
    end
  end,
}
rex.bind("alt+i", "toggle_scratch")
bind("w", "pane.go_to")
bind(",", "client.tab.rename")
bind("shift+4", "session.rename") -- $
bind("shift+5", "pane.split", { direction = "right" }) -- %
bind("shift+'", "pane.split", { direction = "down" }) -- "
bind("z", "pane.zoom")
bind("x", "pane.close")
bind("o", "pane.focus_next")
-- Last focused pane within this tab; history includes mouse navigation.
rex.action{
  name = "last_pane",
  title = "Focus Last Pane",
  run = function(ctx)
    local view = assert(rex.session.view{})
    for _, window in ipairs(view.windows or {}) do
      local visible, order = {}, {}
      for _, layer in ipairs(window.layers or {}) do
        if layer.state ~= "minimized" then
          for _, block in ipairs(layer.blocks or {}) do
            visible[block.block_id] = true
            order[#order + 1] = block.block_id
          end
        end
      end
      -- Use the pane invoking the binding when the client's focus is newer
      -- than the server's active-window snapshot.
      if (ctx.block_id and visible[ctx.block_id])
        or (not ctx.block_id and window.window_id == view.active_window_id) then
        local focused = ctx.block_id or window.focused_block_id
        local path = os.getenv("HOME") .. "/.local/state/rex-pane-history/" .. window.window_id
        local file = io.open(path, "r")
        local current, previous
        if file then
          current, previous = file:read("*l"), file:read("*l")
          file:close()
        end
        -- The watcher may not yet have observed the most recent focus change.
        local target = current ~= focused and current or previous
        if not visible[target] or target == focused then
          target = nil
          for _, id in ipairs(order) do
            if id ~= focused then target = id; break end
          end
        end
        if not target then return end
        local result = assert(rex.session.focus_block{ block_id = target })
        -- Keep rapid repeat presses independent of the watcher round trip.
        local output = assert(io.open(path .. ".toggle", "w"))
        output:write(target, "\n", focused, "\n")
        output:close()
        assert(os.rename(path .. ".toggle", path))
        return result
      end
    end
  end,
}
bind(";", "last_pane")
bind("shift+1", "pane.move_to_new_tab") -- !
bind("]", "pane.paste")
bind("shift+;", "client.palette.toggle") -- : opens Rex commands
bind("shift+/", "client.palette.toggle") -- ? searchable commands/shortcuts
bind("ctrl+space", "pane.send_key", { key = "ctrl+space" })

-- Rex modes have no idle timeout: Escape ends repeat resizing.
rex.mode("resize")
rex.bind("resize/enter", "client.mode.exit")
for _, direction in ipairs({ "left", "down", "up", "right" }) do
  bind(direction, "pane.focus", { direction = direction })
  bind("ctrl+" .. direction, "pane.resize", { direction = direction })
  local action = "resize_start_" .. direction
  rex.action{
    name = action,
    title = "Resize " .. direction .. " and Enter Resize Mode",
    run = function()
      rex.client.queue("pane.resize", { direction = direction })
      rex.client.queue("client.mode.enter", { name = "resize" })
    end,
  }
  bind("alt+" .. direction, action)
  rex.bind("resize/alt+" .. direction, "pane.resize", { direction = direction })
end

-- Your existing prefix-free pane navigation.
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("ctrl+shift+" .. key, "pane.focus", { direction = direction })
end
