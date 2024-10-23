# TrabajoFinalAlgoritmos
Objetivo
Desarrollar un subsistema para gestionar y consultar información sobre alumnos con
problemas de aprendizaje.
Descripción del Proyecto
Se necesita crear un sistema que permita almacenar, consultar y organizar información sobre
alumnos con problemas de aprendizaje, y las dificultades asociadas.
Las dificultades a considerar son las siguientes:
● dificultad 1: Problemas del habla y lenguaje
● dificultad 2: Dificultad para escribir
● dificultad 3: Dificultades de aprendizaje visual
● dificultad 4: Memoria y otras dificultades del pensamiento
● dificultad 5: Destrezas sociales inadecuadas
El Archivo de Alumnos debe contener
● Número Legajo
● Apellido y nombres
● Fecha de Nacimiento
● Estado (baja lógica)
● Discapacidades: array [1..5] of boolean
El Archivo de Evaluaciones debe contener
● Numero Legajo
● Fecha de Evaluación (solo una por dia por estudiante)
● Valoración de Seguimiento por Dificultad : array [1..5] of int [0..4]
● Observación (campo de texto)
