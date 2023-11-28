local status_ui, dapui = pcall(require, 'dapui')
local status, dap = pcall(require, 'dap')
if (not status_ui)
then
    print("You are missing the Dap-UI plugin")
    return
  else if (not status)
  then
  print("You are missing Dap Plugin")
  end
end


config = function()
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
