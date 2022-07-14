# qb-rental

Simple vehicle rental system for QB-CORE.

This system is inspired by [nc-rental](https://github.com/NaorNC/nc-rental)

However this resource has no dependencies except QB-CORE and PolyZone.

## Installation

Download the script and put it in the [resource] folder.

`ensure qb-rental`

Put this line on shared.lua in your core.

```lua
["rentalpapers"]				 = {["name"] = "rentalpapers", 					["label"] = "Rental Papers", 			["weight"] = 50, 		["type"] = "item", 		["image"] = "rentalpapers.png", 		["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false, 	["combinable"] = nil, 	["description"] = "This car was taken out through car rental."}
```

## Adding the RentalPapers to qb-inventory
Go to qb-inventory -> html -> js -> app.js and between lines 500-600 add the following code

```javascript
          } else if (itemData.name == "rentalpapers") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p><strong>Plate: </strong><span>'+ itemData.info.label + '</span></p>');
```
