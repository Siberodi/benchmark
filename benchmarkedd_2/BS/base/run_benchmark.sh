##!/bin/bash
set -e

SOLUTIONS_DIR="/app/soluciones"
LANGUAGES=("python" "csharp" "go" "java" "javascript")
declare -a results

echo "=== Iniciando Benchmark ==="
for lang in "${LANGUAGES[@]}"; do
  FOLDER="$SOLUTIONS_DIR/$lang"
  if [ -d "$FOLDER" ]; then
    echo "=== Construyendo y ejecutando $lang ==="
    cd "$FOLDER"
    docker build -t "benchmark-$lang" .

    # Ejecutar el contenedor y medir el tiempo
    #TIME_START=$(date +%s.%N) 
    docker run --name "benchmark-$lang" "benchmark-$lang"
    #TIME_END=$(date +%s.%N) 
    #TIME_MS=$(echo "scale=3; ($TIME_END - $TIME_START) * 1000" | bc)

    # Copia el archivo output.txt desde el contenedor a la carpeta local.
    docker cp "benchmark-$lang:/app/output.txt" ./output.txt
    docker rm "benchmark-$lang"

    #echo "  - Lenguaje   : $lang"
    #echo "  - Tiempo (ms): $TIME_MS"

    # Obtener la PRIMERA línea para validación
    if [ -f output.txt ]; then
      RESULT=$(sed -n '1p' output.txt)  # Extract only the first line
      if [ -z "$RESULT" ]; then
        RESULT="No disponible"
      fi
    else
      RESULT="Archivo no encontrado"
    fi

    # Obtener la SEGUNDA línea para el benchmark report
    if [ -f output.txt ]; then
      TIME_RESULT=$(sed -n '2p' output.txt)  # Extract second line
      if [ -z "$TIME_RESULT" ]; then
        TIME_RESULT="No disponible"
      fi

      # Eliminar la segunda línea después de obtenerla
      sed -i '2d' output.txt
    else
      TIME_RESULT="Archivo no encontrado"
    fi

    # Validar solo la PRIMERA línea de output.txt
    if [ "$RESULT" == "544383731135652813387342609937503801..." ]; then
      echo "El resultado es correcto"
    else
      echo "El resultado es incorrecto"
    fi
    echo

    cd /app
    results+=("$lang $TIME_RESULT")
  else
    echo "Carpeta $FOLDER no existe. Se omite."
  fi
done

echo "---------------------------------"
echo "| Lenguaje   | Tiempo (ms)      |"
echo "---------------------------------"
for result in "${results[@]}"; do
  lang=$(echo $result | awk '{print $1}')
  time=$(echo $result | awk '{print $2}')
  printf "| %-10s | %-15s |\n" "$lang" "$time"
done
echo "=== Benchmark completado ==="
