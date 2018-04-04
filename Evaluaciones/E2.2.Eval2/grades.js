// Víctor Rendón S. | A01022462 | Evaluación 2

db.createCollection("grades")

// 1) ¿Cuál es el total de alumnos inscritos?
  db.grades.distinct("student_id").length
  // con aggregate:
  db.grades.aggregate([ {
    $group: {
      _id: "$student_id",
    }}]).toArray().length // = 50

// 2) ¿Cuántos cursos se han impartido?
  db.grades.distinct("class_id").length
  // con aggregate:
  db.grades.aggregate([ {
    $group: {
      _id: "$class_id",
    }}]).toArray().length // = 31

// 3) Encuentra, para cada alumno, su promedio obtenido en cada una de las clases en las que fue inscrito (promedia exámenes, quizes, tareas y todas las actividades realizadas que contenga un grade)
  db.grades.aggregate([
    {$unwind : "$scores"},
    {$group: {
      _id: {'student_id': "$student_id", 'class_id': "$class_id"},
      PromedioCalif:{$avg:"$scores.score"}},
    }
  ])

// 4) ¿Cuál fue la materia que tiene la calificación más baja (muestra el id de la materia, el id del alumno y la calificación)?
  db.grades.aggregate([
    {$unwind : "$scores"},
    {$group: {
      _id: {'student_id': "$student_id", 'class_id': "$class_id"},
      PromedioCalif:{$avg:"$scores.score"}},
    },
    {$sort:{PromedioCalif: 1}},
    {$limit: 1}
  ]) // = { "student_id" : 18, "class_id" : 8 }, "PromedioCalif" : 10.206653332610028 }

// 5) ¿Cuál es la materia en la que se han dejado más tareas?


// 6) ¿Qué alumno se inscribió en más cursos?

// 7) ¿Cuál fue el curso que tuvo más reprobados?
  db.grades.aggregate([
    {$unwind : "$scores"},
    {$group: {
      _id: {'student_id': "$student_id", 'class_id': "$class_id"},
      PromedioCalif:{$avg:"$scores.score"}},
    },
    {$sort:{ PromedioCalif: 1}},
    {$match:{ PromedioCalif: { $lt: 70 }}},
    {$group: {
      _id: "$_id.class_id",
      Reprobados:{$sum:1}},
    },
    {$sort:{Reprobados: -1}},
    {$limit: 1},
  ]) // = { "_id" : 22, "Reprobados" : 14 }
