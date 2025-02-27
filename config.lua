Config = {}

Config.Crafting = {
    [1] = { -- Crafting sted 1
        ped = {
            location = vector4(175.3851, -729.5436, 39.4037, 298.8571), -- Ped & Target lokation
            model = "s_m_m_armoured_01", -- Ped model (Kan ændres)
            emote = "" -- Efterlad tom, hvis ingen emote
        },
        items = { -- Uendelige crafting-muligheder, på lokationen.
            {
                title = "Pistol",
                description = "En 9mm pistol, perfekt til selvforsvar.", -- er optional
                icon = "fa-solid fa-gun", -- er optional
                image = "https://cdn.discordapp.com/attachments/1292414050785038379/1343712958278008942/1ed497-pacb-logo.png?ex=67be45b6&is=67bcf436&hm=ab23da30e10d46b7ce7dae49bf327dde89c33faf57f97e281fa7caf82bc47f31&", -- Efterlad tom, hvis du ikke vil tilføje et billede.
                requiredItems = { -- Krævede materialer
                    { item = "money", label = "Penge", amount = 10000 },
                    { item = "armour", label = "Vest", amount = 5 }
                },
                reward = {
                    item = "weapon_pistol", -- Item man modtager
                    amount = 1 -- Antal af item man modtager
                }
            },
            {
                title = "SMG",
                description = "En letvægts SMG, hurtig og dødbringende.",
                icon = "fa-solid fa-gun",
                image = "",
                requiredItems = {
                    { item = "steel", label = "Stål", amount = 200 },
                    { item = "gold", label = "Guld", amount = 50 },
                    { item = "smg_blueprint", label = "SMG Blueprint", amount = 1 }
                },
                reward = {
                    item = "weapon_smg",
                    amount = 1
                }
            }
        }
    }
    -- lav flere crafting steder her :)
}