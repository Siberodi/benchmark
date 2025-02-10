# Benchmark de Fibonacci en Diferentes Lenguajes

Este repositorio contiene un conjunto de programas que calculan la suma de los primeros **10,000** términos de la **serie de Fibonacci** en distintos **lenguajes de programación**. Cada programa mide su tiempo de ejecución para comparar el rendimiento de los diferentes lenguajes.

## Objetivo
El propósito de este proyecto es explorar cómo los diferentes lenguajes ejecutan el cálculo de Fibonacci y comparar su **eficiencia y velocidad** en la ejecución. Además, se busca recorrer contenedor por contenedor para analizar la información en cada uno de ellos.

## Pasos para Ejecutar el Proyecto

Para revisar y verificar los resultados obtenidos con este repositorio, sigue estos pasos:

### 1. Acceder a Play with Docker

- Abre [Play with Docker](https://labs.play-with-docker.com/) en tu navegador web.
- Si no estás registrado, crea una cuenta con tu correo electrónico.
- Haz clic en el botón **ADD NEW INSTANCE** para crear una nueva instancia de Docker.

### 2. Clonar el Repositorio

Ejecuta el siguiente comando en la terminal de Play with Docker para clonar el repositorio:

```bash
 git clone https://github.com/Siberodi/benchmark.git
```

### 3. Navegar a las Carpetas del Proyecto

Una vez clonado el repositorio, navega dentro de las carpetas necesarias con los siguientes comandos:

```bash
 cd benchmark
 cd benchmarkedd_2
 cd BS
 cd base
```

### 4. Construir y Ejecutar los Contenedores

Para correr todos los programas dentro de sus respectivos contenedores, ejecuta:

```bash
 docker compose up --build
```

Este comando **compilará y ejecutará** los programas en los distintos lenguajes dentro de sus contenedores Docker.

### 5. Esperar la Carga y Ver la Comparación de Tiempos

Después de aproximadamente **un minuto**, los procesos terminarán de ejecutarse y se mostrará en la terminal una tabla comparativa similar a la siguiente:

```
---------------------------------
| Lenguaje   | Tiempo (ms)      |
---------------------------------
| python     | 4.64             |
| csharp     | 24               |
| go         | 27               |
| java       | 27               |
| javascript | 7                |
---------------------------------
```

### 6. Revisar Resultados Individualmente

Si deseas visualizar nuevamente los resultados individuales de cada lenguaje, navega a la carpeta del lenguaje deseado y usa el siguiente comando:

```bash
 cat output.txt
```

Este comando mostrará el archivo `output.txt`, que contiene el tiempo de ejecución medido para ese lenguaje en particular.

---

## Notas Adicionales
- Asegúrate de tener **Docker Compose** correctamente instalado y en funcionamiento.
- Si un lenguaje no muestra su tiempo correctamente, revisa los archivos de salida (`output.txt`) y verifica los logs de ejecución.
- Puedes modificar los programas en los distintos lenguajes para optimizar su rendimiento y comparar nuevas implementaciones.

¡Explora y diviértete comparando el rendimiento de los distintos lenguajes de programación! 🚀

