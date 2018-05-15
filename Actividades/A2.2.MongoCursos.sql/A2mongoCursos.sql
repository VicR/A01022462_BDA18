-- Víctor Rendón S. | A01022462

db.createCollection("escuela")
db.escuela.insert({titulo:"Bases de Datos Avanzadas", profesor:[{nombre:"Ariel", apellido: "Garcia Gamboa", matricula:"L49131158", campus:"Santa Fe", semestre:"Ene-May-2018", materias:[{titulo:"Bases de Datos Avanzadas", año:2018}, {titulo:"Lenguajes de Programacion", año:2018}]}], año:2018})
db.escuela.update({titulo:"Bases de Datos Avanzadas"}, {$set:{evaluaciones:[{teoricas: 14, practicas: 9}]}})
db.escuela.update({titulo:"Bases de Datos Avanzadas"}, {$set:{alumnos:[{nombre:"Victor", apellido: "Rendon Suarez", matricula:"A01022462", campus:"Santa Fe", semestre:"Ene-May-2018", materias:[{nombre:"Bases de Datos Avanzadas", año:2018, calificaciones:[{curso:1, calificacion: 82},{curso:1, calificacion:79},{curso:3, calificacion:100},{curso:4, calificacion:90}]}],calificacionFinal:87.75}]}})

-- Response
{
	"_id" : ObjectId("9hv7z755978bd8432ec08c48"),
	"titulo" : "Bases de Datos Avanzadas",
	"profesor" : [
		{
			"nombre" : "Ariel",
			'apellido' : "Garcia Gamboa",
			"matricula" : "L49131158",
			"campus" : "Santa Fe",
			"semestre" : "Ene-May-2018",
			"materias" : [
				{
					"titulo" : "Bases de Datos Avanzadas",
					"año" : 2018
				},
				{
					"titulo" : "Lenguajes de Programacion",
					"año" : 2018
				}
			]
		}
	],
	"año" : 2018,
	"evaluaciones" : [
		{
			"teoricas" : 14,
			"practicas" : 9
		}
	],
	"alumnos" : [
		{
			"nombre" : "Victor",
      "apellido" : "Rendon Suarez",
			"matricula" : "A01022462",
			"campus" : "Santa Fe",
			"semestre" : "Ene-May-2018",
			"materias" : [
				{
					"nombre" : "Bases de Datos Avanzadas",
					"año" : 2018,
					"calificaciones" : [
						{
							"curso" : 1,
							"calificacion" : 82
						},
						{
							"curso" : 1,
							"calificacion" : 79
						},
						{
							"curso" : 3,
							"calificacion" : 100
						},
						{
							"curso" : 4,
							"calificacion" : 90
						}
					]
				}
			],
			"calificacionFinal" : 87.75
		}
	]
}
