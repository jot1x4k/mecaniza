# MECANIZA

Sistema experto interactivo para el diagnóstico de fallas comunes en vehículos automotores, implementado en Prolog (SWI-Prolog) con interfaz gráfica nativa en **XPCE**.

## Ejecución de la Aplicación

### 1. Interfaz Gráfica (XPCE)

Para ejecutar la aplicación con la interfaz gráfica:

```bash
swipl main.pl
```

Al cargarse, la ventana gráfica de **MECANIZA** se abrirá automáticamente en el centro de la pantalla.

También puede invocarse desde la consola de Prolog con:
```prolog
?- iniciar.
```

### 2. Modo Consola

Para entornos sin interfaz gráfica o terminales puramente texto:

```bash
swipl -g iniciar_consola -t halt main.pl
```
