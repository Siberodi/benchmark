package main

import (
    "fmt"
    "log"
    "math/big"
    "os"
    "time"
)

func main() {
    // Medir tiempo de inicio
    inicio := time.Now()

    // Definimos las variables como punteros a big.Int
    f0 := big.NewInt(0) // Fibonacci(0)
    f1 := big.NewInt(1) // Fibonacci(1)
    suma := big.NewInt(0)

    // Iteramos 10,000 veces
    for i := 0; i < 10000; i++ {
        // Sumamos el término actual (f0)
        suma.Add(suma, f0)

        // Calculamos el siguiente número de Fibonacci
        var siguiente big.Int
        siguiente.Add(f0, f1)

        // Avanzamos en la sucesión
        f0.Set(f1)
        f1.Set(&siguiente)
    }

    // Medir tiempo de finalización
    duracion := time.Since(inicio).Milliseconds()

    // Imprimir en consola
    fmt.Printf("Tiempo transcurrido: %d ms\n", duracion)

    // Crear (o sobrescribir) el archivo de salida
    file, err := os.Create("output.txt")
    if err != nil {
        log.Fatalf("Error creando el archivo: %v", err)
    }
    defer file.Close()

    // Escribir la suma en la primera línea
    _, err = fmt.Fprintf(file, "%s\n", suma.String()) 
    if err != nil {
        log.Fatalf("Error escribiendo en el archivo: %v", err)
    }

    // Escribir SOLO el tiempo en la segunda línea (sin texto adicional)
    _, err = fmt.Fprintf(file, "%d\n", duracion) 
    if err != nil {
        log.Fatalf("Error escribiendo en el archivo: %v", err)
    }
}
