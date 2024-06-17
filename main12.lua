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
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Callback = function(Val) end
})


local PerSec = 1


ChatSpammerTimePerDelay:OnChanged(function(Val)
    if Val and PerSec then
        PerSec = Val
    end
end)


local MessageInput = Tabs.Chat:AddInput('ChatSpammerMessageInputbox', {
    Title = 'Message',
    Default = 'Me on Top',
    Placeholder = "The Message that get Send when u Enable 'ChatSpammer'",
    Numeric = false,
    Finished = false,
    Callback = function() end
})





local waitNum = 0



local Message = 'Im on top'



MessageInput:OnChanged(function()
    if Message and MessageInput and MessageInput.Value then
        Message = MessageInput.Value
    end 
end)


local Bool = false
local chatspammerhook = false


local function OnCountdown(bool)
    if Bool == true then
        do
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                if Bool == true then
                    while wait(PerSec / 3) do
                        if Bool == true then
                            local Suc, Mes = pcall(function()
                                local ConfigBar = TextChatService.ChatInputBarConfiguration
                                
                                if ConfigBar then
                                    local TargetTextChannel = ConfigBar.TargetTextChannel

                                    if TargetTextChannel then
                                        TargetTextChannel:SendAsync(Message)
                                    else
                                        warn('DID NOT FIND: TargetTextChannel')
                                    end
                                else
                                    warn('DID NOT FIND: ChatInputBatConfiguration')
                                end
                            end)
                        else
                            break
                        end
                    end


                    if not Suc then
                        warn(Mes)
                    end
                else
                    
                end
            elseif TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
                if Bool == true then
                    local Suc, Mes = pcall(function()
                        local DefaultFolder = ReplicatedStorage:WaitForChild('DefaultChatSystemChatEvents', 10)


                        -- Taken from VXPE
                        if not chatspammerhook then
                            task.spawn(function()
                                chatspammerhook = true
                                
                                for i,v in pairs(getconnections(ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
                                    if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == 'table' and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
                                        oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
										oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel


                                        getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
                                            local tab = oldchannelfunc(Self, Name)
                                            if tab and tab.AddMessageToChannel then
                                                local addmessage = tab.AddMessageToChannel
                                                if oldchanneltabs[tab] == nil then
                                                    oldchanneltabs[tab] = tab.AddMessageToChannel
                                                end
                                                tab.AddMessageToChannel = function(Self2, MessageData)
                                                    if MessageData.MessageType == "System" then
                                                        if MessageData.Message:find("You must wait") and ChatSpammer.Enabled then
                                                            return nil
                                                        end
                                                    end
                                                    return addmessage(Self2, MessageData)
                                                end
                                            end
                                            return tab
                                        end
                                    end
                                end
                            end)
                        end
                        -- Did some Changing
                        task.spawn(function()
                            while wait(PerSec / 3) do
                                if Bool == true then
                                    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack({
                                        [1] = Message,
                                        [2] = 'All'
                                    }))
                                else
                                    break
                                end
                            end
                        end)
                    end)
                end
            end
        end
    end
end


ChatSpammerToggle:OnChanged(function()
    Bool = GuiContain.ChatSpammerToggle.Value

    OnCountdown()
end)





-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/GG/main/main11.lua', true))()
