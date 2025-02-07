#!/bin/bash
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
    TIME_START=$(date +%s.%N) 
    docker run --name "benchmark-$lang" "benchmark-$lang"
    TIME_END=$(date +%s.%N) 
    # Use bc to calculate precise difference
    TIME_MS=$(echo "scale=3; ($TIME_END - $TIME_START) * 1000" | bc)

    # TIME_START=$(date +%s%3N)
    # docker run --name "benchmark-$lang" "benchmark-$lang"
    # TIME_END=$(date +%s%3N)
    # TIME_MS=$((TIME_END-TIME_START))
    
    # Copia el archivo output.txt desde el contenedor a la carpeta local.
    docker cp "benchmark-$lang:/app/output.txt" ./output.txt
    docker rm "benchmark-$lang"

    echo "  - Lenguaje   : $lang"
    echo "  - Tiempo (ms): $TIME_MS"

    #Agregar verificación de errores
    RESULT=$(cat output.txt) #Leer el archivo output.txt de cada lenguaje
    if [ -z "$RESULT" ]; then
      RESULT="No se encontró el archivo output.txt"
    fi

    if [ -f output.txt ]; then
      TIME_RESULT=$(sed -n '2p' output.txt)  # Extraer segunda línea
      if [ -z "$TIME_RESULT" ]; then
        TIME_RESULT="No disponible"
      fi

      # Eliminar la segunda línea del archivo output.txt
      sed -i '2d' output.txt
    else
      TIME_RESULT="Archivo no encontrado"
    fi


    if [ "$RESULT" == 54438373113565281338734260993750380135389184554695967026247715841208582865622349017083051547938960541173822675978026317384359584751116241439174702642959169925586334117906063048089793531476108466259072759367899150677960088306597966641965824937721800381441158841042480997984696487375337180028163763317781927941101369262750979509800713596718023814710669912644214775254478587674568963808002962265133111359929762726679441400101575800043510777465935805362502461707918059226414679005690752321895868142367849593880756423483754386342639635970733756260098962462668746112041739819404875062443709868654315626847186195620146126642232711815040367018825205314845875817193533529827837800351902529239517836689467661917953884712441028463935449484614450778762529520961887597272889220768537396475869543159172434537193611263743926337313005896167248051737986306368115003088396749587102619524631352447499505204198305187168321623283859794627245919771454628218399695789223798912199431775469705216131081096559950638297261253848242007897109054754028438149611930465061866170122983288964352733750792786069444761853525144421077928045979904561298129423809156055033032338919609162236698759922782923191896688017718575555520994653320128446502371153715141749290913104897203455577507196645425232862022019506091483585223882711016708433051169942115775151255510251655931888164048344129557038825477521111577395780115868397072602565614824956460538700280331311861485399805397031555727529693399586079850381581446276433858828529535803424850845426446471681531001533180479567436396815653326152509571127480411928196022148849148284389124178520174507305538928717857923509417743383331506898239354421988805429332440371194867215543576548565499134519271098919802665184564927827827212957649240235507595558205647569365394873317659000206373126570643509709482649710038733517477713403319028105575667931789470024118803094604034362953471997461392274791549730356412633074230824051999996101549784667340458326852960388301120765629245998136251652347093963049734046445106365304163630823669242257761468288461791843224793434406079917883360676846711185597500 ]; then
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

#Save the results in the output.txt file
#output_file="/app/output/output.txt"

#echo "---------------------------------" > "$output_file"
#echo "| Lenguaje   | Tiempo (ms)      |" >> "$output_file"
#echo "---------------------------------" >> "$output_file"
#for result in "${results[@]}"; do
  #lang=$(echo $result | awk '{print $1}')
  #time=$(echo $result | awk '{print $2}')
  #printf "| %-10s | %-15s |\n" "$lang" "$time" >> "$output_file"
#done
#echo "---------------------------------" >> "$output_file"


# Mostrar los resultados en la consola en formato de tabla
echo "---------------------------------"
echo "| Lenguaje   | Tiempo (ms)      |"
echo "---------------------------------"
for result in "${results[@]}"; do
  lang=$(echo $result | awk '{print $1}')
  time=$(echo $result | awk '{print $2}')
  printf "| %-10s | %-15s |\n" "$lang" "$time"
done
echo "---------------------------------"

echo "=== Benchmark completado ==="
