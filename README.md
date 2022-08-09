# Proyecto de Evaluacion y Control de Proyectos

Este es el repositorio donde se encuentra el frontend.

# Formato en envío

## Learning Curve

La aplicación envía POST Request al URL del servidor proporcionado y adjunta un JSON en el body cuyo formato varía dependiendo del formulario que se llena. Existen 3 posibilidades: 'Condiciones Iniciales', 'N-Iteración' o '2 Muestras'.
Los formatos de cada uno son los siguientes:

### Condiciones Iniciales
Se identifica por **"type": 0**

Aquí es cuando se conoce el learning rate y el tiempo invertido en realizar la primera iteración o secuencia.

**maxSequence** es un parámetro que indica para cuántas iteraciones se tiene que calcular (es decir, desde iteración 1 hasta la iteración indicada)


```yaml
{
   "type": 0,             # int
   "learningRate": 0.85,   # double
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

## Monte Carlo

Lo único que se manda es un JSON que contiene un arreglo de actividades. Cada actividad tiene descrito su nombre, el monto mínimo y monto máximo. El formato es de la siguiente forma:

```yaml
{
    "activities": [
        {
            "name": "A",            # String
            "minimum": 0,           # Double
            "maximum": 10           # Double
        },
        {
            "name": "B",            # String
            "minimum": 100,         # Double
            "maximum": 1000         # Double
        },
        {
            "name": "C",            # String
            "minimum": 10000,       # Double
            "maximum": 100000       # Double
        },
        ...
        {
            "name": "N",            # String
            "minimum": 78963,       # Double
            "maximum": 110000       # Double
        }
    ]
}
```

# Formato de Recepción

## Learning Curve

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
- **y2AccumulatedTime (double)**: Representa la cantidad de tiempo acumulado desde la primera iteración hasta la **x-eava** iteración

## Monte Carlo

El formato es el siguiente:

```yaml
{
  "summary": {
        "mean": 350,                        # Double
        "stdev": 20,                        # Double
        "skew": -0.14062060471664342,       # Double
        "kurtosis": 0.0481009845482836,     # Double
        "median": 347.9012982760893,        # Double
        "samples": 400                      # Int
   },
   "values": [                              # Double
      334.58240716118155,
      343.06754292527967,
      331.49749812726213,
      358.29187177968964,
      358.17249458805844,
      334.1626236047862,
      351.5342927001772,
      368.7845703535604,
      361.03727281464273,
      .
      .
      .
   ]
}
```

El JSON de respuesta debe de contener un objeto identificado por **summary** y un arreglo identificado por **values**.

El primero contiene la información estadística de la simulación Monte Carlo y debe de contener las siguientes propiedades:
- **mean**
- **stdev**
- **skew**
- **kurtosis**
- **median**
- **samples**

Y el arreglo debe de contener los valores totales de cada muestra (es decir, la sumatoria final de todas las actividades de cada muestra). Estos deben ser doubles y la cantidad esperada debe ser igual a la cantidad establecida en la propiedad **samples**
