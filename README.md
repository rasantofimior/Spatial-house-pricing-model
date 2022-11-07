# Repositoiro Spatial house pricing model: Cali es cali, lo demás es loma... 

Este repositorio corresponde al Problem Set 3 del curso Big Data and Machine Learning for Applied Economics 2022 - Uniandes.

Datos y archivos de réplica para "Repositoiro para el curso Big Data and Machine Learning for Applied Economics Problem Set 3" por 
[Camilo Bonilla](https://github.com/cabonillah),  [Nicolás Velásquez](https://github.com/Nicolas-Velasquez-Oficial) y  [Rafael Santofimio](https://github.com/rasantofimior/)

# Resumen

En Colombia la fijación del precio de la vivienda varia de región a región, en buena parte depende del grado de desarrollo en términos económicos de cada ciudad, de los planes de ordenamiento territorial - POT (tipo uso de suelo), servicios que pueda prestar (transporte, ambiente, ocio y recreación, etc.), el estado del mercado (la oferta y demanda de inmuebles), entre otros. Así entonces, resulta retador establecer el precio de la vivienda de una ciudad específica y extrapolarlo a otra. Por lo tanto, este trabajo se centra en crear modelos que permiten predecir el precio de la vivienda en Cali, a partir de información del mercado inmobiliario de Medellín y Bogotá. Esta comprende datos relacionados con número de habitaciones, área construida, antigüedad de la vivienda, servicios disponibles para cada barrio, y factores relacionados con el transporte, seguridad y ambiente. Con base esto, ofrecer el servicio técnico a una empresa interesada en el sector inmobiliario de Cali. 


Este repositorio contiene las siguientes carpetas:

## Carpeta Document

-Problem_Set_3.pdf:
Este docuemnto contiene las instrucciones para abordar el reto 3 (predicción del precio de la vivienda en Cali)
-Cali_es_Cali.pdf
Este reporte muestra y describe la data, modelos, resultado y principales conclusiones para atender el reto

## Carpeta Stores

Esta carpeta alberga bases de datos relacionadas con el entrenamiento y testeo. Así como los resultados de cada modelos.
- test.Rds
- train.Rds
- st_maps_key_val.csv
- predictions_bonilla_santofimio_velasquez.csv
Este archivo contiene las predicciones de los dos mejores modelos construidos

## Carpeta Scripts:

-   El análisis de datos se realiza utilizando el software R version 4.0.2 (2022-09-05)
    -   La carpeta scripts contine los codigos nombrados a continución:

        -   data_prep
        -   get_nb
        -   get_dist
        -   data_polution_light

## Carpeta Views:

La carpeta Views contine las tablas y figuras nombrados a continución:
        -   xxx

Notas:

-   Si se ejecutan los scripts desde programas como R Studio, se debe asegurar antes que el directorio base se configure en "Spatial-house-pricing-model\scripts".
-   Se recomienda enfacticamnete seguir las instrucciones y comentarios del código (en orden y forma). Así mismo, es importante que antes de verificar la              replicabilidad del código, se asegure de tener **todos** los requerimientos informáticos previamente mencionados (i.e. se prefieren versiones de **R** menores a la 4.2.1. para evitar que paquetes, funciones y métodos que han sido actualizados no funcionen). Además, la velocidad de ejecución dependerá de las características propias de su máquina, por lo que deberá (o no) tener paciencia mientras se procesa.*
