Config = {}
Config.locale = 'fr'

Config.vehicleList = {
    { name = "BMX", model = "bmx", price = 10, needLicense = false},
    { name = "Faggio", model = "faggio", price = 100, needLicense = true },
    { name = "Blista", model = "blista", price = 500 , needLicense = true},
}

Config.spawns = {
    vector4(-1041.76, -2676.22, 13.41, 324.13),
    vector4(-1031.88, -2658.51, 13.65, 150.12),
    vector4(-1049.05, -2669.5, 13.65, 308.46),
    vector4(-1040.39, -2653.34, 13.65, 148.59),
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


