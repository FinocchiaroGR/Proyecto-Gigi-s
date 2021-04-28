const Arrow = require('../models/arrow');
const Ciclo = require('../models/ciclos');
const Programa = require('../models/programas')
const Usuario = require('../models/usuarios');

const arrows = Arrow.fetchAll();
const mes = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril', 
    'Mayo',
    'Junio',
    'Julio', 
    'Agosto',
    'Septiembre', 
    'Octubre', 
    'Noviembre',
    'Diciembre'
];
const grupos = [{numero: '1'}, {numero: '2'}] 

exports.getInsGrupo = (request,response,next) => {
    response.render('gc_inscribir', {
        tituloDeHeader: "Inscribir participantes",
        tituloBarra: "Inscribir participantes en Lectura",
        backArrow: {display: 'block', link: '/gestionAdmin/gestionCiclos'},
        forwArrow: arrows[1]
    });
};

exports.getAgrCiclo = (request,response,next) => {
    Programa.fetchAll()
    .then(([programas, fieldData1]) => {
        Usuario.fetchNomTerapeutas()
        .then(([terapeutas, fieldData1]) => {
            response.render('agregar_ciclo', {
                programas: programas,
                terapeutas: terapeutas,
                grupos: grupos,
                tituloDeHeader: "Nuevo ciclo",
                tituloBarra: "Nuevo ciclo",
                backArrow: {display: 'block', link: '/gestionAdmin/gestionCiclos'},
                forwArrow: arrows[1]
            });
        })
        .catch((err) => console.log(err));
    })
    .catch((err) => console.log(err));
};

exports.postSelProg = (request,response,next) => {
    
};

exports.postSelTera = (request,response,next) => {
    
};

exports.getPerfilCiclo = (request,response,next) => {
    response.render('gestion_perfil_ciclo', {
        programas: programas,
        tituloDeHeader: "Ciclo EM-21",
        tituloBarra: "Ciclo enero - marzo 2021",
        backArrow: {display: 'block', link: '/gestionAdmin/gestionCiclos'},
        forwArrow: arrows[1]
    });
};

exports.get = (request,response,next) => {
    Ciclo.fetchAll()
        .then(([ciclos, fieldData1]) => {
            Ciclo.fetchCiclosAnioActual()
                .then(([ciclos_aactual, fieldData1]) => {
                    Ciclo.fetchAniosPasados()
                        .then(([a_pasados, fieldData1]) => {
                            response.render('gestion_ciclos', {
                                ciclos: ciclos,
                                a_pasados:a_pasados,
                                ciclos_aactual: ciclos_aactual,
                                mes: mes,
                                tituloDeHeader: "Gestión de ciclos",
                                tituloBarra: "Ciclos",
                                backArrow: {display: 'block', link: '/gestionAdmin'},
                                forwArrow: arrows[1]
                            });
                        })
                        .catch((err) => console.log(err));
                })
                .catch((err) => console.log(err));
        })
        .catch((err) => console.log(err));
};
