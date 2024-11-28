local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local UIlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/55zay16/Dexion/refs/heads/main/UIlib.lua"))()

Values = {

}


local Rivals = UIlib:Init("Rivals")

local CombatTab = UIlib:AddTab(Rivals,"Combat",0.092,0,0.106,0) 
local MovementTab = UIlib:AddTab(Rivals,"Movement",0.092 + 0.167,0,0.106,0)
local VisualsTab = UIlib:AddTab(Rivals,"Visuals",0.092 + (0.167 * 2),0,0.106,0)
local UtilitysTab = UIlib:AddTab(Rivals,"Utility",0.092 + (0.167 * 3),0,0.106,0)

