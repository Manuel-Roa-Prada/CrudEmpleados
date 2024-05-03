<%-- 
    Document   : peticionesEmpleados
    Created on : 2/05/2024, 11:03:16?a. m.
    Author     : manol
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Logica.Empleados"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>
<%
    String respuesta = "{";

    List<String> tareas = Arrays.asList(new String[]{
        "guardarEmpleado",
        "listar",
        "eliminar",
        "actualizar"
    });
    String proceso = "" + request.getParameter("proceso");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("guardarEmpleado")) {

            String nombre = request.getParameter("nombre");
            String cedula = request.getParameter("cedula");
            String email = request.getParameter("email");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");

            Empleados e = new Empleados(nombre, cedula, email, direccion, telefono);

            if (e.guardarEmpleados()) {
                respuesta += "\"guardarEmpleado\": true";
            } else {
                respuesta += "\"guardarEmpleado\": false";
            }
        } else if (proceso.equals("listar")) {
            try {
                List<Empleados> lista = new Empleados().listarEmpleados();
                respuesta += "\"" + proceso + "\": true,\"datosempleados\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"datosempleados\":[]";
                Logger.getLogger(Empleados.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Empleados e = new Empleados();
            e.setId(id);
            if (e.eliminarEmpleado()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("actualizar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String cedula = request.getParameter("cedula");
            String email = request.getParameter("email");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");

            Empleados r = new Empleados();
            r.setId(id);
            r.setNombres(nombre);
            r.setCedula(cedula);
            r.setEmail(email);
            r.setDireccion(direccion);
            r.setTelefono(telefono);
            
            if (r.actualizarEmpleado()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else {
            respuesta += "\"ok\": false,";
            respuesta += "\"error\": \"INVALID\",";
            respuesta += "\"errorMsg\": \"La tarea solicitada no es válida.\"";
        }

        respuesta += "}";
        response.setContentType("application/json;charset=UTF-8");
        out.print(respuesta);
%>