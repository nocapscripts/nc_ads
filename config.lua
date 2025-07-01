Config = Config or {}


---SETTINGS---
Config.Core = 'nc'


Config.CustomNotify = true -- Custom notify Default: false


Config.Command = "ad" -- The ad command name

Config.Jobs = { -- Required jobs init
    'police',
    'ambulance',
    'mechanic',
    'tuner',
    'burgershot',
    'bennys',
}

---LANGUAGE---
Language = { 
    UI = "AD CREATOR",
    Title = "Title",
    EnterTitle = "Enter your title",
    Description = "Description",
    EnterDescription = "Enter description etc text",
    Nojob = "You are not listed to do that!",
    Error = "^1Error: You are not allowed!" -- Chat message

}