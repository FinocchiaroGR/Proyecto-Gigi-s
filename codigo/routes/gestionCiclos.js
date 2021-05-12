const express = require('express');
const subrouter = express.Router();
const path = require('path');
const bodyParser = require('body-parser');

subrouter.use(bodyParser.urlencoded({ extended: false }));

const gestionCicloController = require('../controllers/gestion_ciclos_controller');
const isAuth = require('../util/is-auth.js');

subrouter.get('/inscribir-en-grupo', isAuth, gestionCicloController.getInsGrupo);

subrouter.post('/selProg', isAuth, gestionCicloController.postGrupos);

subrouter.get('/agregar-ciclo', isAuth, gestionCicloController.getAgrCiclo);

subrouter.post('/agregar-ciclo', isAuth, gestionCicloController.postAgrCiclo);

subrouter.get('/gestion-perfil-ciclo', isAuth, gestionCicloController.getPerfilCiclo);

subrouter.get('/', isAuth, gestionCicloController.get);

module.exports = subrouter;
