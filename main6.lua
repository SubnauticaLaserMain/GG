--- Service(s) ---
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TextChatService = game:GetService('TextChatService')
local TweenService = game:GetService('TweenService')
local CorePackages = game:GetService('CorePackages')
local HttpService = game:GetService('HttpService')
local GuiService = game:GetService('GuiService')
local StarterGui = game:GetService('StarterGui')
local CoreGui = game:GetService('CoreGui')


--- Varible(s) ---
local ChatVersion = TextChatService.ChatVersion




local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))


InterfaceManager = InterfaceManager and InterfaceManager() or nil
SaveManager = SaveManager and SaveManager() or nil
Fluent = Fluent and Fluent() or nil


local GuiContain = Fluent.Options


local Window = Fluent:CreateWindow({
    Title = 'Script : GuiLibrary Version: ' .. tostring(Fluent.Version),
    SubTitle = 'Works on all Games!',
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})


local Tabs = {
    Main = Window:AddTab({
        Title = 'Main',
        Icon = 'box'
    }),
    Chat = Window:AddTab({
        Title = 'Chat',
        Icon = 'box'
    })
}


local ChatSpammerToggle = Tabs.Chat:AddToggle('ChatSpammerToggle', {
    Title = 'ChatSpammer',
    Default = false
})

local ChatSpammerTimePerDelay = Tabs.Chat:AddSlider('TimePerDelayForChatSpammer', {
    Title = 'Time Per Delay - [Seconds] : ChatSpammer',
    Description = "Set the time that the 'ChatSpammer' is gonna Spam per [Second]",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(Val) end
})


local PerSec = 1


ChatSpammerTimePerDelay:OnChanged(function(Val)
    if Val and PerSec then
        PerSec = Val
    end
end)



local waitNum = 0





local Bool = false


local function OnCountdown(bool)
    if Bool == true then
        while (PerSec / 10) do
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                if Bool == true then
                    local Suc, Mes = pcall(function()
                        local ConfigBar = TextChatService.ChatInputBarConfiguration
                        
                        if ConfigBar then
                            local TargetTextChannel = ConfigBar.TargetTextChannel

                            if TargetTextChannel then
                                TargetTextChannel:SendAsync('This is a message')
                            else
                                warn('DID NOT FIND: TargetTextChannel')
                            end
                        else
                            warn('DID NOT FIND: ChatInputBatConfiguration')
                        end
                    end)


                    if not Suc then
                        warn(Mes)
                    end
                else
                    break
                end
            end
        end
    end
end


ChatSpammerToggle:OnChanged(function()
    Bool = GuiContain.ChatSpammerToggle.Value

    OnCountdown()
end)





-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/GG/main/main5.lua', true))()
