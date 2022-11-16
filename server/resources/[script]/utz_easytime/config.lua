Config = {}

Config.UseESX = true --Enable if you are using ESX so you can use the esx permissions.
Config.Command = 'easytime' --Customise the command name to open the UI.
Config.Notification_Type = 'chat' ----chat / mythic_old / mythic_new / esx / custom
Config.Language = 'EN' --EN / FR / ES

Config.TimeCycleSpeed = 2000 -- Changing this value will effects the day/night time cycle, decreasing slows it down, incresing speeds it up. Right now its similar to the default gta5 time cycle. (in milliseconds).
Config.DynamicWeather = true --Enable if you want to allow dynamic weather.
Config.DynamicWeather_time = 10 --If dynamic weather is enabled, this value is how long until the weather changes (in minutes).
Config.RainChance = 10 --The percent chance for it to rain out of 100.
Config.SnowChance = 1 --The percent chance for it to snow out of 100.
Config.ThunderChance = 20 --The percent chance for it to thunder when raining out of 100.

Config.WeatherGroups = { --
    [1] = {'CLEAR', 'OVERCAST','EXTRASUNNY', 'CLOUDS'},--clear
    [2] = {'CLEARING', 'RAIN', 'NEUTRAL', 'THUNDER'},--rain
    [3] = {'SMOG', 'FOGGY'},--foggy
    [4] = {'SNOWLIGHT', 'SNOW', 'BLIZZARD', 'XMAS'},--snow
}
