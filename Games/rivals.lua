local UIlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/55zay16/Dexion/refs/heads/main/UIlib.lua"))()

Values = {
    ["uninject"] = false,
}


local Rivals = UIlib:Init("Rivals")

local CombatTab = UIlib:AddTab(Rivals,"Combat",0.092,0,0.106,0) 
local MovementTab = UIlib:AddTab(Rivals,"Movement",0.092 + 0.167,0,0.106,0)
local VisualsTab = UIlib:AddTab(Rivals,"Visuals",0.092 + (0.167 * 2),0,0.106,0)
local UtilitysTab = UIlib:AddTab(Rivals,"Utility",0.092 + (0.167 * 3),0,0.106,0)


local Running = true

local MainThread = coroutine.create(function()
    while Running do
        task.wait()

        if Values["uninject"] == true then
            Rivals:Destroy()
            for _,i in pairs(Values) do
                i = false
            end
            Running = false
        end
    end
end)

local TempDisableAura = false
local CombatThread = coroutine.create(function()
    while Running do
        task.wait()
    end
end)

local MovementThread = coroutine.create(function()
    while Running do
        task.wait()
    end
end)

local VisualsThread = coroutine.create(function()
    while Running do
        task.wait()
    end
end)

local UtilitysThread = coroutine.create(function()
    while Running do
        task.wait()
    end
end)

coroutine.resume(MainThread)   
coroutine.resume(CombatThread)
coroutine.resume(MovementThread)
coroutine.resume(VisualsThread)
coroutine.resume(UtilitysThread)

