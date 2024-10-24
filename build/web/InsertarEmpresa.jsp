<%-- 
    Document   : InsertarEmpresa
    Created on : 23 oct. 2024, 18:34:17
    Author     : josee
--%>

<%@page import="Beans.EmpresaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insertar Empresa</title>
        <script type="text/javascript">
            function validacion() {
                // Validar Nombre Empresa
                var nombreEmpresa = document.getElementById("nombreEmpresa").value;
                if (nombreEmpresa == null || nombreEmpresa.length == 0 || /^\s+$/.test(nombreEmpresa)) {
                    alert("*Campo vacío... Debes colocar el Nombre de la Empresa");
                    return false;
                }
                
                // Validar Razón Social
                var razonSocial = document.getElementById("razonSocial").value;
                if (razonSocial == null || razonSocial.length == 0 || /^\s+$/.test(razonSocial)) {
                    alert("*Campo vacío... Debes colocar la Razón Social");
                    return false;
                }

                // Validar Giro
                var giro = document.getElementById("giro").value;
                if (giro == null || giro.length == 0 || /^\s+$/.test(giro)) {
                    alert("*Campo vacío... Debes colocar el Giro de la Empresa");
                    return false;
                }
                
                return true; // Si todas las validaciones son correctas
            }
        </script>
    </head>
    <body>
        <h1>Registro de Empresa</h1>
        <%
            if (request.getParameter("submit") == null) {
        %>
        <form onsubmit="return validacion()">
            <center>
                <table border="1" cellpadding="5" cellspacing="0">
                    <tr>
                        <td><label for="nombreEmpresa">Nombre de Empresa:</label></td>
                        <td><input type="text" id="nombreEmpresa" name="nombreEmpresa" size="25" /></td>
                    </tr>
                    <tr>
                        <td><label for="razonSocial">Razón Social:</label></td>
                        <td><input type="text" id="razonSocial" name="razonSocial" size="25" /></td>
                    </tr>
                    <tr>
                        <td><label for="giro">Giro:</label></td>
                        <td><input type="text" id="giro" name="giro" size="25" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" id="submit" name="submit" value="Crear Empresa" />
                            <input type="reset" value="Limpiar" />
                        </td>
                    </tr>
                </table>
                <a href="EliminarEmpresa.jsp">Regresar</a>
                
            </center>
        </form>
        <% 
            } else {
                // Código que se ejecuta tras enviar el formulario
                Mapeos.Empresa nuevaEmpresa = new Mapeos.Empresa();
                nuevaEmpresa.setNombreEmpresa(request.getParameter("nombreEmpresa"));
                nuevaEmpresa.setRazonSocial(request.getParameter("razonSocial"));
                nuevaEmpresa.setGiro(request.getParameter("giro"));

                EmpresaDAO empresaDAO = new EmpresaDAO();
                int idEmpresa = empresaDAO.guardarEmpresa(nuevaEmpresa);

                if (idEmpresa > 0) {
        %>
        <h2>Empresa registrada exitosamente con ID: <%= idEmpresa %></h2>
        <a href="InsertarEmpresa.jsp">Registrar otra Empresa</a>
        <% 
                } else { 
        %>
        <h2>Ocurrió un error al intentar registrar la empresa. Inténtalo de nuevo.</h2>
        <a href="InsertarEmpresa.jsp">Volver a Intentar</a>
        <% 
                }
            } 
        %>
    </body>
</html>
