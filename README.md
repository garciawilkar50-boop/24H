# Pétalos de Reinicio

**Sauce Solitario · RPG narrativo por turnos · Android y PC**

Este branch contiene el prototipo web de **Pétalos de Reinicio**, adaptado para desarrollarse y probarse desde un teléfono. La versión web usa HTML, CSS y JavaScript nativos; no requiere instalar Godot ni compilar para probar el prototipo.

## Empezar desde el celular
- [Abrir el prototipo web](PetalosDeReinicio/web/index.html)
- [Instrucciones de la versión web](PetalosDeReinicio/web/README.md)
- [Flujo de trabajo Canva + GitHub móvil](PetalosDeReinicio/docs/FLUJO_CANVA_GITHUB_MOVIL.md)
- [Fichas visuales para el Acto 1](PetalosDeReinicio/docs/FICHAS_CANVA_ACTO_1.md)
- [Plan narrativo de los cinco actos](PetalosDeReinicio/docs/PLAN_ACTOS.md)

## Qué funciona en el prototipo web
- Menú principal y navegación responsive para móvil y escritorio.
- Mapa exploratorio 2D dibujado en Canvas, con Vera y controles táctiles/teclado.
- Flor coleccionable, inventario y estadísticas.
- Encuentro con Lenteja y combate por turnos: Luchar, Actuar, Objeto, Perdonar y Huir.
- Guardado local en el navegador del dispositivo.

## Canva y assets
El diseño visual se está organizando en Canva. Exporta los recursos originales como PNG y súbelos desde el móvil a GitHub para integrarlos progresivamente en `PetalosDeReinicio/web/assets/`.

## Estado honesto
Este es un prototipo jugable temprano, no el juego completo de cuatro horas. Los archivos se han guardado en GitHub, pero todavía hace falta abrirlo en Chrome Android y probar cada flujo; aún no se ha publicado con GitHub Pages ni generado una APK nativa. El guardado actual es local a un navegador y no sincroniza entre dispositivos.

La carpeta de Godot queda como material heredado de la primera iteración; el desarrollo nuevo prioriza la versión web.
