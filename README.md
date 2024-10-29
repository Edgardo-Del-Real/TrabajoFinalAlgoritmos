# TrabajoFinalAlgoritmos
<h2>Objetivo</h2>
<p>Desarrollar un subsistema para gestionar y consultar información sobre alumnos con
problemas de aprendizaje.</p>

<h2>Descripción del Proyecto</h2>
<p>Se necesita crear un sistema que permita almacenar, consultar y organizar información sobre
alumnos con problemas de aprendizaje, y las dificultades asociadas.</p>
<h2>Las dificultades a considerar son las siguientes:</h2>
● dificultad 1: Problemas del habla y lenguaje
<br>
● dificultad 2: Dificultad para escribir
<br>
● dificultad 3: Dificultades de aprendizaje visual
<br>
● dificultad 4: Memoria y otras dificultades del pensamiento
<br>
● dificultad 5: Destrezas sociales inadecuadas
<br>
<h2>El Archivo de Alumnos debe contener</h2>
● Número Legajo
<br>
● Apellido y nombres
<br>
● Fecha de Nacimiento
<br>
● Estado (baja lógica)
<br>
● Discapacidades: array [1..5] of boolean
<br>
<h2>El Archivo de Evaluaciones debe contener</h2>
● Numero Legajo
<br>
● Fecha de Evaluación (solo una por dia por estudiante)
<br>
● Valoración de Seguimiento por Dificultad : array [1..5] of int [0..4]
<br>
● Observación (campo de texto)

<h2> NOTAS </h2>
●El trabajo se deberá implementar con archivos random.
<br>
●El archivo de Alumnos se mantendrá ordenado mediante árboles binarios de búsqueda (uno por Número de Legajo y uno por Apellido y Nombres, con clave y pos_relativa_maestro) 
y el Archivo de evaluaciones, por fecha
<br>
● Debe estar modularizado en Units.
<br>
● Se puede agregar cualquier aporte que considere conveniente, justificando.
<br>
● Se presupone que el usuario será personal del área de educación, por lo que la carga y
<br>
● visualización de los datos debe ser práctica y amigable.





