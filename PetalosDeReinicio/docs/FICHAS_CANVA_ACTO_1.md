# Fichas Canva — Acto I: Jardín de Cobre
Carpeta del proyecto en Canva: https://www.canva.com/folder/FAHX8uKY6Sc

**Estado:** Canva devolvió un límite de créditos durante la generación automática. Estas fichas son especificaciones para crear diseños manualmente desde el móvil; no son imágenes ya exportadas.

## Dirección de arte
Pixel art indie de 16 bits, siluetas claras y ambiente melancólico/esperanzador. Paleta: noche `#101923`, suelo `#263A35`, cobre `#B76D57`, pétalo `#D7A9F2`, dorado `#D9B96B`, crema `#F4E8D7`, menta `#8FCAC4`.

## Nilo — protagonista
Sprite de referencia 128×128 PNG transparente; capa violeta `#A78BD4`, piel `#E7C5A4`, sombra `#3D425E`, mechón oscuro. Diseñar idle frontal, cuatro poses de caminar, sorpresa, tristeza y alivio. Exportar `nilo_idle.png`, `nilo_walk.png`, `nilo_portrait.png`.

## Tic — relojero
Sprite 128×128 y retrato 512×512; dorado `#D9B96B`, bronce `#8E6945`, crema `#F0D9A3`. Personaje bajo, cabeza redonda con marcas de reloj y sonrisa nerviosa. Exportar `tic_idle.png`, `tic_portrait.png`, `item_engranaje.png`.

## Vera — guardiana botánica
Sprite 128×128 y retrato 512×512; menta `#8FCAC4`, verde `#3D695C`, piel `#E8C9A8`. Cabello como hojas, abrigo corto y flor en el hombro. Exportar `vera_idle.png`, `vera_portrait.png`.

## Lenteja — criatura semilla
Sprite 128×128; estados neutral, asustado y amigable. Verde `#B8C17A`, crema `#F5E9C7`, oliva `#505B37`. Semilla redonda, patas pequeñas y ojos grandes. Exportar `lenteja_idle.png`, `lenteja_friendly.png`, `lenteja_portrait.png`.

## Raíz Hueca — guardián final
Concepto 1024×1024; raíces oscuras, piezas de cobre y silueta legible, no terrorífica. Exportar `raiz_hueca.png`, `raiz_hueca_portrait.png`.

## Escenarios y UI
- `jardin_cobre_bg.png`: 1920×1080, claro, sendero cobrizo, arcos y flores.
- `tile_jardin.png`: hoja de tiles de suelo, camino, raíces, piedras y flores.
- `ui_petal.png`: icono de pétalo, 256×256.
- `ui_panels.png`: botones, marcos y paneles de diálogo.
- `item_te_rocio.png`: frasco curativo.
- `item_mapa_raices.png`: mapa enrollado.
- `mockup_title_mobile.png`, `mockup_exploration_mobile.png`, `mockup_battle_mobile.png`: 1080×1920.
- `mockup_pc.png`: interfaz horizontal 1920×1080.

## Exportación desde el teléfono
1. Crea los diseños editables en la carpeta Canva.
2. Exporta sprites e iconos como PNG transparente cuando esté disponible.
3. Centra los sprites con márgenes coherentes.
4. Sube los archivos a `PetalosDeReinicio/web/assets/` en GitHub.
5. Integra y prueba un recurso a la vez. El prototipo conserva gráficos temporales dibujados en Canvas hasta que se sustituyan.
