# MECANIZA

Sistema experto interactivo para el diagnóstico de fallas comunes en vehículos automotores, implementado en Prolog (SWI-Prolog) con interfaz gráfica nativa en **XPCE**.

Proyecto desarrollado para el curso **Estructuras de Lenguajes** por **Juan José Rodríguez Prada** (`jot1x4k`).

---

## 📋 Especificación y Diseño

El sistema implementa el caso de uso **"Gestionar respuesta del usuario"** detallado en `docs/especificacion.md`, siguiendo el flujo del diagrama de secuencia en `docs/diagrama_secuencia.png` y los prototipos de interfaz en `docs/prototipos/`:

1. **`home_view`**: Pantalla inicial con título, subtítulo, botón de inicio de diagnóstico y botón de salida.
2. **`form_view`**: Presentación iterativa de preguntas con botones **"Si"** y **"No"**.
3. **`diagnostic_view`**: Presentación del diagnóstico inferido junto con la solución recomendada y acción preventiva. En caso de no alcanzarse una conclusión (flujo alternativo), informa que el diagnóstico no es preciso y solicita intentar nuevamente. Permite volver al menú principal en cualquier momento.

---

## 🏗️ Estructura del Proyecto

```text
mecaniza/
├── docs/
│   ├── diagrama_secuencia.png
│   ├── especificacion.md
│   └── prototipos/
│       ├── Untitled-2026-11-03-2133.excalidraw
│       └── Untitled-2026-11-03-2133.png
├── src/
│   ├── base.pl            # Base de conocimiento (problema_info/6)
│   ├── preguntas.pl       # Definicion de preguntas y gestion dinamica de respuestas
│   ├── diagnostico.pl     # Reglas logicas de inferencia
│   ├── motor.pl           # Controlador del caso de uso (desacoplado de la UI)
│   └── gui.pl             # Interfaz grafica en XPCE (home_view, form_view, diagnostic_view)
├── test/
│   ├── motor_test.pl      # Pruebas automatizadas del motor de inferencia
│   └── gui_test.pl        # Pruebas automatizadas de la interfaz grafica
├── main.pl                # Punto de entrada principal
└── README.md              # Documentacion de uso
```

---

## 🚀 Requisitos de Ejecución

- **SWI-Prolog** versión 8.x o 9.x (incluye librería gráfica `XPCE`).
- Sistema operativo Linux / macOS / Windows con soporte para entorno gráfico X11/Wayland/GDI.

Verificar instalación:
```bash
swipl --version
```

---

## 💻 Ejecución de la Aplicación

### 1. Interfaz Gráfica (XPCE) - Modo Principal

Para ejecutar la aplicación con la interfaz gráfica:

```bash
swipl main.pl
```

Al cargarse, la ventana gráfica de **MECANIZA** se abrirá automáticamente en el centro de la pantalla.

También puede invocarse desde la consola de Prolog con:
```prolog
?- iniciar.
```

### 2. Modo Consola (CLI)

Para entornos sin interfaz gráfica o terminales puramente texto:

```bash
swipl -g iniciar_consola -t halt main.pl
```

---

## 🧪 Pruebas Automatizadas

El proyecto cuenta con suites de pruebas unitarias integradas utilizando `plunit`:

```bash
# Pruebas del motor y flujos logicos:
swipl -g run_tests -t halt test/motor_test.pl

# Pruebas de la interfaz grafica y transicion de estados:
swipl -g run_tests -t halt test/gui_test.pl
```
