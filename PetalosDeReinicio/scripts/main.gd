extends Node2D

const PlayerScene = preload("res://scenes/player.tscn")
const StateScript = preload("res://scripts/game_state.gd")

var state
var player
var ui: CanvasLayer
var status_label: Label
var message_label: Label
var battle_panel: PanelContainer
var battle_text: Label
var nearby := ""
var tic_pos := Vector2(760, 480)
var vera_pos := Vector2(1080, 350)
var lentil_pos := Vector2(1390, 640)
var petal_pos := Vector2(1580, 510)
var world_time := 0.0
var battle_active := false
var enemy_hp := 12
var battle_turn := 0
var dialogue_lines: Array[String] = []
var dialogue_index := 0

func _ready() -> void:
    state = StateScript.new()
    add_child(state)
    if not state.load_game():
        state.hp = 20
        state.energy = 10
    player = PlayerScene.instantiate()
    add_child(player)
    player.position = Vector2(260, 520)
    _build_ui()
    _say("Te despiertas sobre tierra tibia. Encima de ti, una máquina arcade repite una melodía con una nota equivocada. Acércate a Tic y Vera.")
    _refresh_status()

func _process(delta: float) -> void:
    world_time += delta
    _update_nearby()
    queue_redraw()

func _draw() -> void:
    draw_rect(Rect2(0, 0, 1920, 1080), Color("#111923"))
    draw_rect(Rect2(0, 90, 1920, 910), Color("#263a35"))
    for x in range(0, 1920, 96):
        for y in range(120, 1000, 96):
            draw_circle(Vector2(x + 32 + sin(float(x * 3 + y) * 0.017) * 8.0, y + 26), 2.5, Color("#40564a"))
    draw_rect(Rect2(80, 455, 1760, 110), Color("#655342"))
    draw_rect(Rect2(420, 150, 110, 760), Color("#655342"))
    draw_rect(Rect2(1180, 150, 110, 760), Color("#655342"))
    for x in [560, 790]:
        draw_rect(Rect2(x, 105, 180, 125), Color("#263044"))
        draw_rect(Rect2(x + 15, 120, 150, 75), Color("#7b638f"))
        draw_rect(Rect2(x + 30, 133, 120, 48), Color("#a8d9d0"))
    for p in [Vector2(180,260), Vector2(350,720), Vector2(690,770), Vector2(1000,690), Vector2(1500,280), Vector2(1720,790)]:
        _draw_flower(p)
    _draw_npc(tic_pos, Color("#d9b96b"), "TIC")
    _draw_npc(vera_pos, Color("#8fcac4"), "VERA")
    if not state.flags.get("lentil_defeated", false) and not state.flags.get("lentil_spared", false):
        _draw_lentil(lentil_pos)
    _draw_petal(petal_pos)
    draw_rect(Rect2(0, 0, 1920, 92), Color("#0b1119"))
    draw_string(ThemeDB.fallback_font, Vector2(42, 58), "PÉTALOS DE REINICIO", HORIZONTAL_ALIGNMENT_LEFT, -1, 28, Color("#e8d5b7"))
    draw_string(ThemeDB.fallback_font, Vector2(1470, 58), "ACTO 1 · JARDÍN DE COBRE", HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color("#a9c9bc"))

func _draw_flower(p: Vector2) -> void:
    for i in range(5):
        var a := float(i) * TAU / 5.0
        draw_circle(p + Vector2(cos(a), sin(a)) * 13.0, 8.0, Color("#b76d57"))
    draw_circle(p, 7.0, Color("#e7c889"))
    draw_line(p + Vector2(0, 8), p + Vector2(0, 31), Color("#708c61"), 3.0)

func _draw_npc(p: Vector2, tint: Color, tag: String) -> void:
    draw_circle(p + Vector2(0, 28), 19, Color(0, 0, 0, 0.18))
    draw_rect(Rect2(p + Vector2(-15, -7), Vector2(30, 37)), tint)
    draw_circle(p + Vector2(0, -22), 16, Color("#e8c9a8"))
    draw_circle(p + Vector2(-5, -23), 2, Color("#202331"))
    draw_circle(p + Vector2(5, -23), 2, Color("#202331"))
    draw_string(ThemeDB.fallback_font, p + Vector2(-24, -48), tag, HORIZONTAL_ALIGNMENT_LEFT, 80, 14, Color("#f0e8d7"))

func _draw_lentil(p: Vector2) -> void:
    draw_circle(p, 24, Color("#b8c17a"))
    draw_circle(p + Vector2(-8,-5), 4, Color("#f5e9c7"))
    draw_circle(p + Vector2(8,-5), 4, Color("#f5e9c7"))
    draw_circle(p + Vector2(-8,-5), 1.8, Color("#252a2d"))
    draw_circle(p + Vector2(8,-5), 1.8, Color("#252a2d"))
    draw_arc(p + Vector2(0,3), 8, 0.2, PI - 0.2, 12, Color("#505b37"), 2)
    draw_string(ThemeDB.fallback_font, p + Vector2(-30,-36), "LENTEJA", HORIZONTAL_ALIGNMENT_LEFT, 80, 14, Color("#e8e4b9"))

func _draw_petal(p: Vector2) -> void:
    draw_circle(p, 25, Color(0.76, 0.52, 0.92, 0.12))
    for i in range(6):
        var a := float(i) * TAU / 6.0 + world_time * 0.25
        draw_circle(p + Vector2(cos(a), sin(a)) * 14.0, 8, Color("#d7a9f2"))
    draw_circle(p, 8, Color("#fff0bb"))
    draw_string(ThemeDB.fallback_font, p + Vector2(-35,43), "PÉTALO", HORIZONTAL_ALIGNMENT_LEFT, 80, 14, Color("#f2d7ff"))

func _build_ui() -> void:
    ui = CanvasLayer.new()
    add_child(ui)
    var root := Control.new()
    root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    ui.add_child(root)
    status_label = Label.new()
    status_label.position = Vector2(36, 105)
    status_label.add_theme_font_size_override("font_size", 20)
    status_label.add_theme_color_override("font_color", Color("#f1e7d5"))
    root.add_child(status_label)
    message_label = Label.new()
    message_label.position = Vector2(330, 820)
    message_label.size = Vector2(1110, 145)
    message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    message_label.add_theme_font_size_override("font_size", 22)
    message_label.add_theme_color_override("font_color", Color("#f4e9d8"))
    root.add_child(message_label)

    _button(root, "INTERACTUAR [E]", Vector2(1510,900), Vector2(340,72)).pressed.connect(_interact)
    _button(root, "GUARDAR", Vector2(1510,985), Vector2(160,54)).pressed.connect(_save)
    _button(root, "ESTADO", Vector2(1690,985), Vector2(160,54)).pressed.connect(_show_status)
    _button(root, "▲", Vector2(128,770), Vector2(80,70)).button_down.connect(func(): player.virtual_direction = Vector2.UP)
    _button(root, "▼", Vector2(128,920), Vector2(80,70)).button_down.connect(func(): player.virtual_direction = Vector2.DOWN)
    _button(root, "◀", Vector2(42,845), Vector2(80,70)).button_down.connect(func(): player.virtual_direction = Vector2.LEFT)
    _button(root, "▶", Vector2(214,845), Vector2(80,70)).button_down.connect(func(): player.virtual_direction = Vector2.RIGHT)
    for child in root.get_children():
        if child is Button:
            child.button_up.connect(func(): player.virtual_direction = Vector2.ZERO)

func _button(parent: Control, caption: String, pos: Vector2, dimensions: Vector2) -> Button:
    var b := Button.new()
    b.text = caption
    b.position = pos
    b.size = dimensions
    b.add_theme_font_size_override("font_size", 19)
    b.add_theme_color_override("font_color", Color("#f4e8d7"))
    var style := StyleBoxFlat.new()
    style.bg_color = Color("#27303b")
    style.border_color = Color("#a78bd4")
    style.set_border_width_all(2)
    style.set_corner_radius_all(15)
    b.add_theme_stylebox_override("normal", style)
    parent.add_child(b)
    return b

func _update_nearby() -> void:
    nearby = ""
    if player.position.distance_to(tic_pos) < 100: nearby = "tic"
    elif player.position.distance_to(vera_pos) < 100: nearby = "vera"
    elif player.position.distance_to(petal_pos) < 90: nearby = "petal"
    elif player.position.distance_to(lentil_pos) < 100 and not state.flags.get("lentil_defeated", false) and not state.flags.get("lentil_spared", false): nearby = "lentil"

func _interact() -> void:
    if battle_active: return
    if not dialogue_lines.is_empty():
        _advance_dialogue()
        return
    match nearby:
        "tic":
            state.flags["met_tic"] = true
            state.bond = mini(100, state.bond + 3)
            _open_dialogue([
                "TIC: ¡Oh! Has vuelto a encenderte. Eso suele ser mala señal.",
                "NILO: ¿Quién eres?\nTIC: Un reloj con piernas emocionales. Y tú eres Nilo. Creo. El jardín borra las etiquetas.",
                "TIC: Vera está junto a los monolitos. Habla con ella antes de acercarte a esa cosa verde."
            ])
        "vera":
            state.flags["met_vera"] = true
            state.memories = maxi(state.memories, 1)
            _open_dialogue([
                "VERA: No pises las flores que brillan. Son recuerdos de alguien.",
                "NILO: ¿Y las que no brillan?\nVERA: Esas son flores normales. Creo. Aquí la botánica tiene problemas de identidad.",
                "VERA: El pétalo conserva lo que eres ahora. No lo que eras."
            ])
        "petal":
            state.checkpoint = "jardin_cobre_petal_01"
            state.flags["first_petal"] = true
            state.hp = state.max_hp
            state.energy = state.max_energy
            state.save_game()
            _say("PÉTALO ACTIVADO: progreso guardado; HP y ENERGÍA restaurados. Una voz susurra: «Esta vez, intenta recordar por qué huiste».")
        "lentil":
            if not state.flags.get("met_tic", false) or not state.flags.get("met_vera", false):
                _say("Lenteja tiembla, pero no se acerca. Habla con Tic y Vera primero.")
            else: _start_battle()
        _:
            _say("Oyes el zumbido de máquinas enterradas. Acércate a alguien o a algo para interactuar.")

func _open_dialogue(lines: Array) -> void:
    dialogue_lines.clear()
    for line in lines: dialogue_lines.append(str(line))
    dialogue_index = 0
    player.movement_enabled = false
    _say(dialogue_lines[0] + "\n\nPulsa E / INTERACTUAR para continuar.")

func _advance_dialogue() -> void:
    dialogue_index += 1
    if dialogue_index >= dialogue_lines.size():
        dialogue_lines.clear()
        player.movement_enabled = true
        _say("Explora el Jardín de Cobre. Habla con ambos personajes y acércate a Lenteja.")
    else:
        _say(dialogue_lines[dialogue_index] + "\n\nPulsa E / INTERACTUAR para continuar.")

func _start_battle() -> void:
    battle_active = true
    player.movement_enabled = false
    enemy_hp = 12
    battle_turn = 0
    battle_panel = PanelContainer.new()
    battle_panel.position = Vector2(420, 180)
    battle_panel.size = Vector2(1080, 600)
    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color("#151b27")
    panel_style.border_color = Color("#c9a4e9")
    panel_style.set_border_width_all(3)
    panel_style.set_corner_radius_all(22)
    battle_panel.add_theme_stylebox_override("panel", panel_style)
    ui.add_child(battle_panel)
    var col := VBoxContainer.new()
    col.add_theme_constant_override("separation", 18)
    battle_panel.add_child(col)
    var title := Label.new()
    title.text = "¡LENTEJA BLOQUEA EL CAMINO!"
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title.add_theme_font_size_override("font_size", 30)
    col.add_child(title)
    battle_text = Label.new()
    battle_text.custom_minimum_size = Vector2(0, 170)
    battle_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    battle_text.add_theme_font_size_override("font_size", 22)
    col.add_child(battle_text)
    var row := HBoxContainer.new()
    col.add_child(row)
    for action in ["LUCHAR","ACTUAR","OBJETO","PERDONAR","HUIR"]:
        var btn := Button.new()
        btn.text = action
        btn.custom_minimum_size = Vector2(180, 70)
        btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        row.add_child(btn)
        match action:
            "LUCHAR": btn.pressed.connect(_fight)
            "ACTUAR": btn.pressed.connect(_act)
            "OBJETO": btn.pressed.connect(_item)
            "PERDONAR": btn.pressed.connect(_spare)
            "HUIR": btn.pressed.connect(_flee)
    _battle_say("LENTEJA · HP 12/12\nIntención: intenta parecer peligrosa. Patrón: tres saltos lentos.\n\n¿Qué harás?")

func _battle_say(text_value: String) -> void:
    if is_instance_valid(battle_text):
        battle_text.text = text_value + "\n\nNILO HP %d/%d · ENERGÍA %d/%d · VÍNCULO %d" % [state.hp,state.max_hp,state.energy,state.max_energy,state.bond]

func _fight() -> void:
    _choice_dialog("MINIJUEGO DE PRECISIÓN", "El núcleo parpadea: LENTO — RÁPIDO — LENTO. Elige tu ritmo.", [
        ["LENTO", func(): _resolve_fight(5)],
        ["RÁPIDO", func(): _resolve_fight(2)]
    ])

func _resolve_fight(damage: int) -> void:
    if not battle_active: return
    enemy_hp -= damage
    state.karma += 2
    state.energy = maxi(0, state.energy - 1)
    if enemy_hp <= 0:
        state.flags["lentil_defeated"] = true
        state.defeated_enemies.append("Lenteja")
        state.update_route()
        _end_battle("Lenteja cae de espaldas. «¡Me has vencido! Díselo a mi madre. Bueno… no sé si tengo madre.»")
    else:
        _enemy_turn("Tu golpe hace %d de daño." % damage)

func _act() -> void:
    _choice_dialog("ACTUAR · LENTEJA", "Elige cómo acercarte a la criatura.", [
        ["REVERENCIA", func(): state.bond = mini(100,state.bond+20); _enemy_turn("Te inclinas. Lenteja intenta devolverte la reverencia y rueda por el suelo. VÍNCULO +20.")],
        ["PREGUNTAR", func(): state.bond = mini(100,state.bond+12); _enemy_turn("Lenteja confiesa que solo quería que alguien le preguntara cómo estaba. VÍNCULO +12.")],
        ["CHISTE MALO", func(): state.bond = mini(100,state.bond+8); _enemy_turn("Tu chiste es tan malo que Lenteja olvida su enfado. VÍNCULO +8.")]
    ])

func _item() -> void:
    if state.inventory.has("Semilla tibia"):
        state.inventory.erase("Semilla tibia")
        state.hp = mini(state.max_hp,state.hp+6)
        state.bond = mini(100,state.bond+8)
        _enemy_turn("Usas la Semilla tibia: recuperas 6 HP y Lenteja olfatea el aire.")
    else:
        _battle_say("No te quedan objetos. Lenteja te mira con una mezcla de pena y juicio.")

func _spare() -> void:
    if state.bond >= 20:
        state.flags["lentil_spared"] = true
        state.spared_enemies.append("Lenteja")
        state.karma -= 1
        state.update_route()
        _end_battle("PERDONAS a Lenteja. Te entrega una hoja de cobre como si fuera un diploma.")
    else:
        _enemy_turn("Lenteja aún tiene miedo. Usa ACTUAR para ganarte su confianza antes de perdonarla.")

func _flee() -> void:
    if battle_turn > 0:
        state.karma += 1
        _end_battle("Consigues huir. Lenteja no te sigue, pero el jardín recordará que la dejaste atrás.")
    else:
        _enemy_turn("El sendero se retuerce y te devuelve al mismo sitio. Todavía no puedes escapar.")

func _choice_dialog(title_text: String, body_text: String, choices: Array) -> void:
    var dialog := ConfirmationDialog.new()
    dialog.title = title_text
    dialog.dialog_text = body_text
    for choice in choices:
        dialog.add_button(choice[0], true, str(choices.find(choice)))
    dialog.custom_action.connect(func(action):
        var idx := int(action)
        if idx >= 0 and idx < choices.size():
            choices[idx][1].call()
        dialog.queue_free()
    )
    dialog.canceled.connect(func(): dialog.queue_free())
    ui.add_child(dialog)
    dialog.popup_centered()

func _enemy_turn(prefix: String) -> void:
    battle_turn += 1
    var damage := 3 if battle_turn % 2 == 1 else 2
    state.hp -= damage
    _refresh_status()
    if state.hp <= 0:
        state.hp = 1
        if state.checkpoint != "":
            state.load_game()
            state.hp = maxi(1,state.hp)
        _end_battle("Tu silueta se deshace en cuadrados. El pétalo te devuelve al último guardado. La muerte no es el final.")
    else:
        _battle_say(prefix + "\n\nTurno de Lenteja: salto triple. Recibes %d de daño. Próximo patrón: salto rápido." % damage)

func _end_battle(text_value: String) -> void:
    battle_active = false
    if is_instance_valid(battle_panel): battle_panel.queue_free()
    player.movement_enabled = true
    if state.flags.get("lentil_spared", false) or state.flags.get("lentil_defeated", false):
        lentil_pos = Vector2(-1000,-1000)
    _say(text_value)
    _refresh_status()
    state.save_game()

func _say(value: String) -> void:
    if is_instance_valid(message_label): message_label.text = value

func _refresh_status() -> void:
    if is_instance_valid(status_label):
        status_label.text = "HP %d/%d · ENERGÍA %d/%d\nVÍNCULO %d/100 · RECUERDOS %d\nRUTA: %s · KARMA: %d" % [state.hp,state.max_hp,state.energy,state.max_energy,state.bond,state.memories,state.route,state.karma]

func _show_status() -> void:
    _say("ESTADO · HP %d/%d · ENERGÍA %d/%d · VÍNCULO %d/100 · RECUERDOS %d · RUTA %s · KARMA %d\nINVENTARIO: %s" % [state.hp,state.max_hp,state.energy,state.max_energy,state.bond,state.memories,state.route,state.karma,", ".join(state.inventory)])

func _save() -> void:
    _say("Progreso guardado." if state.save_game() else "No se pudo guardar. Comprueba el almacenamiento.")

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_E or event.keycode == KEY_SPACE:
            _interact()
        elif event.keycode == KEY_ESCAPE:
            _show_status()
