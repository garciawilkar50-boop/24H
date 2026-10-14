extends Node

const SAVE_PATH := "user://petalos_save.json"

var hp: int = 20
var max_hp: int = 20
var energy: int = 10
var max_energy: int = 10
var bond: int = 0
var memories: int = 0
var karma: int = 0
var route: String = "Neutral"
var act: int = 1
var checkpoint: String = "jardin_cobre_petal_01"
var inventory: Array[String] = ["Semilla tibia"]
var flags: Dictionary = {
    "met_tic": false, "met_vera": false, "lentil_spared": false,
    "lentil_defeated": false, "first_petal": false
}
var defeated_enemies: Array[String] = []
var spared_enemies: Array[String] = []

func update_route() -> void:
    if not defeated_enemies.is_empty() and spared_enemies.is_empty():
        route = "Genocida"
    elif defeated_enemies.is_empty() and not spared_enemies.is_empty():
        route = "Pacifista"
    else:
        route = "Neutral"

func save_game() -> bool:
    var data := {
        "hp": hp, "max_hp": max_hp, "energy": energy, "max_energy": max_energy,
        "bond": bond, "memories": memories, "karma": karma, "route": route,
        "act": act, "checkpoint": checkpoint, "inventory": inventory,
        "flags": flags, "defeated_enemies": defeated_enemies,
        "spared_enemies": spared_enemies
    }
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file == null:
        return false
    file.store_string(JSON.stringify(data, "\t"))
    file.close()
    return true

func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        return false
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file == null:
        return false
    var parsed = JSON.parse_string(file.get_as_text())
    file.close()
    if typeof(parsed) != TYPE_DICTIONARY:
        return false
    hp = int(parsed.get("hp", 20))
    max_hp = int(parsed.get("max_hp", 20))
    energy = int(parsed.get("energy", 10))
    max_energy = int(parsed.get("max_energy", 10))
    bond = int(parsed.get("bond", 0))
    memories = int(parsed.get("memories", 0))
    karma = int(parsed.get("karma", 0))
    route = str(parsed.get("route", "Neutral"))
    act = int(parsed.get("act", 1))
    checkpoint = str(parsed.get("checkpoint", "jardin_cobre_petal_01"))
    inventory.clear()
    for item in parsed.get("inventory", ["Semilla tibia"]):
        inventory.append(str(item))
    flags = parsed.get("flags", flags)
    defeated_enemies.clear()
    for item in parsed.get("defeated_enemies", []):
        defeated_enemies.append(str(item))
    spared_enemies.clear()
    for item in parsed.get("spared_enemies", []):
        spared_enemies.append(str(item))
    return true

func heal_at_petal() -> void:
    hp = max_hp
    energy = max_energy
