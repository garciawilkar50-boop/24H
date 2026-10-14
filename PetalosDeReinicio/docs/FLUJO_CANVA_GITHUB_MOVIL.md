# Flujo móvil: Canva + GitHub
## Diseño en Canva
Usa la carpeta **Pétalos de Reinicio — Diseño del videojuego** para conservar la dirección artística y los mockups. Exporta los assets visuales como PNG; para sprites, utiliza fondo transparente y encuadre consistente. Nombra archivos de forma simple: `vera_idle.png`, `tic_portrait.png`, `lenteja.png`, `bosque_claro.png`.

## Añadir assets desde el teléfono
1. En Canva, abre el diseño y exporta PNG.
2. En GitHub móvil, entra a `PetalosDeReinicio/web/assets/` (crear las carpetas si no existen) y sube los PNG.
3. Actualiza `index.html` para usar esos recursos. Mantén el dibujo Canvas como respaldo mientras los assets se integran.
4. Abre el HTML publicado con GitHub Pages para verificar tamaño y legibilidad.

## Publicación web
En GitHub: Settings → Pages → Build and deployment → Deploy from a branch. Selecciona la rama `petalos-reinicio` y la carpeta `/PetalosDeReinicio/web` si GitHub Pages ofrece esa carpeta como fuente; si no, usa una rama de publicación dedicada con los archivos web en su raíz o configura GitHub Actions.

## Seguridad y expectativas
No coloques contraseñas, claves API ni secretos en HTML. El guardado actual es local al navegador y no sincroniza entre dispositivos. Esta versión es un prototipo web; no es una APK nativa.
