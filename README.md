# Proyecto de Evaluacion y Control de Proyectos

Este es el repositorio donde se encuentra el front end.

# Formato en envío

## Learning Curve

La aplicación envía POST Request al URL del servidor proporcionado y adjunta un JSON en el body cuyo formato varía dependiendo del si el formulario que se llena es 'Condiciones Iniciales', 'N-Iteración' o '2 Muestras'.
Los formatos de cada uno son los siguientes:

### Condiciones Iniciales
Se identifica por **"type": 0**

Aquí es cuando se conoce el learning rate y el tiempo invertido en realizar la primera iteración o secuencia.

**maxSequence** es un parámetro que indica para cuántas iteraciones se tiene que calcular (es decir, desde iteración 1 hasta la iteración indicada)


```yaml
{
   "type": 0,             # int
   "learningRate": .85,   # double
   "time": 500.25,        # double
   "maxSequence": 50,     # int
}
```

### N-Iteración
Se identifica por **"type": 1**

Aquí es cuando se conoce qué iteración es la que uno se encuentra y también el tiempo invertido en realizar dicha iteración. Adicionalmente, se conoce (o se tiene una idea) de cuánto tiempo se invirtió en la primera iteración.

**maxSequence** es un parámetro que indica para cuántas iteraciones se tiene que calcular (es decir, desde iteración 1 hasta la iteración indicada)


```yaml
{
   "type": 1,                     # int
   "sequenceNumber": 6,           # int
   "sequenceTime": 117.96,        # double
   "firstSequenceTime": 117.96,   # double
   "maxSequence": 50,             # int
}
```

### 2 Muestras
Se identifica por **"type": 2**

Aquí es cuando se conoce (o se tiene idea) del número de iteración y el tiempo invertido para 2 muestras. Es útil cuando no se conoce algún dato de la primera iteración.

**maxSequence** es un parámetro que indica para cuántas iteraciones se tiene que calcular (es decir, desde iteración 1 hasta la iteración indicada)

```yaml
{
   "type": 2,                 # int
   "aSequenceNumber": 6,      # int
   "aSequenceTime": 80.25,    # double
   "bSequenceNumber": 13,     # int
   "bSequenceTime": 62.75,    # double
   "maxSequence": 50,         # int
}
```

# Formato de Recepción

La aplicación recibe un JSON como respuesta y el formato esperado es de la siguiente manera:

```yaml
{
  "series": [
    {
      "y1Time": 0,                      # double
      "y2AccumulatedTime": 0,           # double
      "xSequence": 0                    # int
    },
    {
      "y1Time": 1,                      # double
      "y2AccumulatedTime": 1,           # double
      "xSequence": 1                    # int
    },
    {
      "y1Time": 2,                      # double
      "y2AccumulatedTime": 3,           # double
      "xSequence": 2                    # int
    },
    ...
    {
      "y1Time": 243234,                 # double
      "y2AccumulatedTime": 1325453,     # double
      "xSequence": 49                   # int
    }
  ]
}
```

El JSON de respuesta debe de contener un arreglo identificado por **series** y este debe debe de contener **N cantidad de objetos** pedida por el parámetro **maxSequenceNumber**.

Cada objeto debe de contener:
- **xSequence (int)**: Representa la x-eava iteración.
- **y1Time (double)**: Representa la cantidad de tiempo invertida en realizar la **x-eava** iteración
- **y2AccumulatedTime (double)**: Representa la cantidad de tiempo accumulada realizar la primera iteración hasta la **x-eava** iteración
