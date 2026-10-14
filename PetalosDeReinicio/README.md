# Pétalos de Reinicio — Acto 1
**Estudio:** Sauce Solitario · **Motor:** Godot 4.2+ · **Plataformas:** Android horizontal y PC.

## Estado
Prototipo inicial: escenario dibujado por GDScript, Nilo controlable, NPCs Tic y Vera, primer combate contra Lenteja, acciones LUCHAR/ACTUAR/OBJETO/PERDONAR/HUIR, estadísticas y guardado JSON.

## Abrir
1. Descarga/clona el repositorio y abre la carpeta `PetalosDeReinicio` en Godot Project Manager.
2. Importa `project.godot` y pulsa Ejecutar.
3. En PC mueve a Nilo con WASD/flechas y usa E/Espacio para interactuar.
4. Habla con Tic y Vera antes de acercarte a Lenteja.
5. El pétalo violeta guarda y restaura HP/Energía. El botón GUARDAR guarda en `user://petalos_save.json`.

## Android
Instala Godot export templates de la misma versión, Android Studio/SDK y OpenJDK 17. Configura sus rutas en Editor Settings > Export > Android. Abre Proyecto > Exportar, crea/ajusta el preset Android y exporta un APK debug para probar. Para Play Store, configura firma release y exporta AAB. No compartas la clave de firma. El preset incluido es una plantilla inicial; Godot puede requerir que lo regenere con el SDK y versión exactos.

## Canva
Los sprites temporales se dibujan por código. Para reemplazarlos, crea PNG transparentes y guárdalos en:
- `assets/sprites/personajes/nilo.png`
- `assets/sprites/personajes/tic.png`
- `assets/sprites/personajes/vera.png`
- `assets/sprites/enemigos/lenteja.png`
- `assets/backgrounds/jardin_cobre.png`
- `assets/ui/petal_icon.png`

Usa 128×128 o 256×256 para personajes y 1920×1080 para el fondo. En Godot usa filtro nearest para conservar el pixel art.
