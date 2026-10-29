import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = { title: "Veyro — Tu espacio, tus reglas", description: "Comunidades y conversaciones privadas, en un solo lugar." };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="es"><body>{children}</body></html>; }
