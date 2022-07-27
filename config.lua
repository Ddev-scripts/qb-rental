Config = {}
Config.locale = 'fr'

Config.vehicleList = {
    { name = "BMX", model = "bmx", price = 10, needLicense = false},
    { name = "Faggio", model = "faggio", price = 100, needLicense = true },
    { name = "Blista", model = "blista", price = 500 , needLicense = true},
}

Config.locations = {
    {
        id = 1,
        spawnPed = vector4(-1017.93, -2703.8, 13.76, 156.15),
        spawns = {
            vector4(-1041.76, -2676.22, 13.41, 324.13),
            vector4(-1031.88, -2658.51, 13.65, 150.12),
            vector4(-1049.05, -2669.5, 13.65, 308.46),
            vector4(-1040.39, -2653.34, 13.65, 148.59),
        }
    },
    {
        id = 2,
        spawnPed = vector4(-680.08, -1112.02, 14.67, 25.94),
        spawns = {
            vector4(-696.55, -1104.76, 14.35, 30.88),
            vector4(-703.46, -1108.87, 14.35, 32.42),
            vector4(-697.4, -1120.53, 14.35, 31.27),
            vector4(-694.52, -1119.05, 14.35, 31.04),
        }
    },
    {
        id = 3,
        spawnPed = vector4(-1279.27, -424.1, 34.27, 310.12),
        spawns = {
            vector4(-1272.84, -419.68, 33.74, 214.13),
            vector4(-1306.65, -408.93, 34.65, 300.59),
            vector4(-1285.25, -428.51, 34.35, 212.86),
            vector4(-1291.47, -400.54, 35.63, 299.69),
        }
    },
    {
        id = 4,
        spawnPed = vector4(-514.38, 70.27, 52.59, 177.02),
        spawns = {
            vector4(-535.4, 54.81, 52.4, 85.78),
            vector4(-535.4, 47.66, 52.4, 84.59),
            vector4(-523.62, 46.21, 52.4, 83.23),
            vector4(-521.84, 52.78, 52.4, 82.76),
        }
    },
    {
        id = 5,
        spawnPed = vector4(315.49, -1088.15, 29.4, 89.43),
        spawns = {
            vector4(307.06, -1093.99, 29.18, 123.26),
            vector4(306.28, -1103.07, 29.21, 121.33),
            vector4(306.29, -1085.94, 29.21, 120.82),
            vector4(306.47, -1080.89, 29.2, 119.83),
        }
    },
    {
        id = 6,
        spawnPed = vector4(260.55, -638.64, 40.57, 75.18),
        spawns = {
            vector4(247.77, -648.96, 38.93, 340.02),
            vector4(255.13, -631.16, 40.43, 335.25),
            vector4(259.95, -621.65, 41.33, 332.5),
            vector4(226.25, -633.01, 39.5, 157.6),
        }
    }
}
Config.translations = {
    en = {
        rent = 'Rent a vehicle',
        back = 'Return the vehicle (Recover 50% of the rental price)',
        success_back = 'You returned the vehicle, and you got back $',
        info_back = 'Remember to return this vehicle to recover 50% of the price of the vehicle.',
        error_no_license = 'You do not have the necessary license to be able to rent this vehicle',
        error_no_money = 'You do not have enough money.',
        error_no_papers = 'I can\'t take a vehicle without its papers.',
        error_not_a_rent = 'This is not a rented vehicle.',
        error_to_far = 'I don\'t see any rented vehicles, please make sure they are nearby',
        error_all_emplacement_used = 'All spawn locations are in use',
    },
    fr = {
        rent = 'Louer un véhicule',
        back = 'Rendre le véhicule (Récupérer 50% du prix de la location)',
        success_back = 'Vous avez rendu le véhicule, et vous avez récupéré $',
        info_back = 'Pensez à rendre ce véhicule pour récupérer 50% du prix du véhicule.',
        error_no_license = 'Vous n\'avez pas la license nécéssaire pour pouvoir louer ce véhicule',
        error_no_money = 'Vous n\'avez pas assez d\'argent.',
        error_no_papers = 'Je ne peux pas prendre un véhicule sans ses papiers.',
        error_not_a_rent = 'Ce n\'est pas un véhicule loué.',
        error_to_far = 'Je ne vois aucun véhicule loué, assurez-vous qu\'il se trouve à proximité',
        error_all_emplacement_used = 'Tous les emplacements de spawn sont en cours d\'utilisation',
    }

    -- add more languages
}


