# Base/Dockerfile
FROM docker:dind

# Instala bash y git dentro de la imagen
RUN apk update && apk add --no-cache bash git

# Crea carpeta de trabajo
WORKDIR /app

# Copia el script de orquestación
COPY run_benchmark.sh /app/run_benchmark.sh
RUN chmod +x /app/run_benchmark.sh

# Al iniciar el contenedor, se ejecuta el script
CMD ["/app/run_benchmark.sh"]
