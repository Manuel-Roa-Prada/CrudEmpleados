<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crud Básico</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    </head>
    <body ng-app="demoU1" ng-controller="u1Controller as u1">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h2>Formulario</h2>
                    <form>
                        <label for="nombre">Nombre:</label><br>
                        <input type="text" id="nombre" name="nombre" ng-model="u1.nombre" required><br>
                        <input type="text" id="nombre" name="nombre" ng-model="u1.id" ng-hide="u1.inputId" >
                        
                        <label for="cedula">Cédula:</label><br>
                        <input type="text" id="cedula" name="cedula" ng-model="u1.cedula" required><br>

                        <label for="email">Email:</label><br>
                        <input type="email" id="email" name="email" ng-model="u1.email" required><br>

                        <label for="direccion">Dirección:</label><br>
                        <input type="text" id="direccion" name="direccion" ng-model="u1.direccion" required><br>

                        <label for="telefono">Teléfono:</label><br>
                        <input type="tel" id="telefono" name="telefono" ng-model="u1.telefono" required><br><br>

                        <button type="submit" ng-click="u1.validar()" ng-hide="u1.botonGuardar">Guardar</button>
                        <button type="submit" ng-click="u1.actualizar()" ng-hide="u1.botonActualizar">Actualizar</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <h2>Empleados</h2>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Cédula</th>
                                <th>Email</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="u in u1.Empleados">
                                <td>{{u.id}}</td>
                                <td>{{u.nombres}}</td>
                                <td>{{u.cedula}}</td>
                                <td>{{u.email}}</td>
                                <td>{{u.direccion}}</td>
                                <td>{{u.telefono}}</td>
                                <td>
                                    <button class="btn btn-danger btn-sm" ng-click="u1.eliminar(u)">Eliminar</button>
                                    <button class="btn btn-outline-warning" ng-click="u1.llenarDatosEdicion(u)">Editar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script>
                    var app = angular.module('demoU1', []);
                    app.controller('u1Controller', ['$http', controladorU1]);

                    function controladorU1($http) {
                        var u1 = this;
                        u1.Empleados = [];
                        u1.botonGuardar = false;
                        u1.botonActualizar = true;
                        u1.inputId = true;




                        // Función para guardar un empleado
                        u1.guardar = function () {
                            var parametros = {
                                proceso: 'guardarEmpleado',
                                nombre: u1.nombre,
                                cedula: u1.cedula,
                                email: u1.email,
                                direccion: u1.direccion,
                                telefono: u1.telefono
                                
                            };

                            $http({
                                method: 'POST',
                                url: 'peticionesEmpleados.jsp',
                                params: parametros
                            }).then(function (res) {
                                if (res.data.ok === true) {
                                    if (res.data.guardarEmpleado === true) {
                                        alert('Guardó Correctamente');
                                        window.location.reload();
                                    } else {
                                        alert('No Guardó');
                                    }
                                } else {
                                    alert('Error en la solicitud');
                                }
                            }, function (error) {
                                alert('Error en la solicitud');
                                console.error('Error:', error);
                            });
                        };
                        //funcion para listar
                        u1.listarEmpleados = function () {
                            var parametros = {
                                proceso: 'listar'
                            };
                            $http({
                                method: 'POST',
                                url: 'peticionesEmpleados.jsp',
                                params: parametros
                            }).then(function (res) {
                                console.log(res.data);
                                u1.Empleados = res.data.datosempleados;
                            }).catch(function (error) {
                                console.error('Error en la solicitud HTTP:', error);
                            });
                        };
                        u1.listarEmpleados();
                        // Función para validar el formulario
                        u1.validar = function () {
                            if (u1.nombre === undefined || u1.cedula === undefined || u1.email === undefined || u1.direccion === undefined || u1.telefono === undefined) {
                                alert('Llenar todos los campos');
                            } else {
                                u1.guardar();
                            }
                        };
                        //funcion para eliminar
                        u1.eliminar = function (u) {
                            var parametros = {
                                proceso: 'eliminar',
                                id: u.id
                            };
                            $http({
                                method: 'POST',
                                url: 'peticionesEmpleados.jsp',
                                params: parametros
                            }).then(function (res) {
                                if (res.data.ok === true) {
                                    if (res.data.eliminar === true) {
                                        alert('Usuario eliminado');
                                        window.location.reload();
                                    } else {
                                        alert('No se eliminó');
                                    }

                                } else {
                                    alert(res.data.errorMsg);
                                }
                         
                            });

                        };
                     //funcion para llenar datos de edicion
                     u1.llenarDatosEdicion = function(u){
                         u1.botonGuardar = true;
                         u1.botonActualizar = false;
                         u1.nombre = u.nombres;
                         u1.cedula = u.cedula;
                         u1.direccion = u.direccion;
                         u1.email = u.email;
                         u1.telefono = u.telefono;
                         u1.id = u.id;
                         
                         
                     };
                     
                     //funcion actualizar
                     u1.actualizar = function () {

                            var parametros = {
                                proceso: 'actualizar',
                                id: u1.id,
                                nombre: u1.nombre,
                                email: u1.email,
                                direccion: u1.direccion,
                                telefono: u1.telefono
                            };
                            $http({
                                method: 'POST',
                                url: 'peticionesEmpleados.jsp',
                                params: parametros
                            }).then(function (res) {
                                if (res.data.ok === true) {
                                    if (res.data.actualizar === true) {
                                        alert('Empleado actualizado');
                                        window.location.reload();
                                    } else {
                                        alert('No se actualizó');
                                    }

                                } else {
                                    alert(res.data.errorMsg);
                                    
                                }
                            });
                        };
                    }
        </script>
    </body>
</html>

