<%-- 
    Document   : EliminarEmpresa
    Created on : 23 oct. 2024, 18:42:29
    Author     : josee
--%>
<%-- 
    Document   : EliminarEmpresa
    Created on : 23/10/2024
    Author     : Search
--%>

<%@page import="Mapeos.Empresa"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EmpresaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Empresa</title>
    </head>
    <body>
        <h1>Portal de información de la empresa</h1>
        <% 
            EmpresaDAO empresaDAO = new EmpresaDAO();
            List<Empresa> listaEmpresas = empresaDAO.obtenListaEmpresas();
        %>
        <form>
            <HR> 
            <I>Para eliminar una empresa seleccionarla en la columna final <a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>.
            </HR>
            <table border="1">
                <thead>
                    <tr>
                        <th>ID Empresa</th>
                        <th>Nombre Empresa</th>
                        <th>Razón Social</th>
                        <th>Giro</th>
                        <th>Seleccionar</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Empresa empresa : listaEmpresas) { %>
                    <tr>
                        <td><%= empresa.getIdEmpresa() %></td>
                        <td><%= empresa.getNombreEmpresa() %></td>
                        <td><%= empresa.getRazonSocial() %></td>
                        <td><%= empresa.getGiro() %></td>
                        <td><input type="checkbox" name="cbEmpresas" value="<%= empresa.getIdEmpresa() %>"/></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <input type="submit" value="Eliminar Seleccionados" name="eliminar" />
            <input type="button" onclick=" location.href='InsertarEmpresa.jsp' " value="Insertar Empresa" name="boton" />
            <input type="button" onclick=" location.href='ModificarEmpresa.jsp' " value="Modificar Empresa" name="boton" />
        </form>
        <%
            if (request.getParameter("eliminar") != null) {
                String[] chbEmpresas = request.getParameterValues("cbEmpresas");
                if (chbEmpresas != null) {
                    for (int i = 0; i < chbEmpresas.length; i++) {
                        out.println("<li>Empresa ID: " + chbEmpresas[i] + " ha sido eliminada.");
                        empresaDAO.eliminaEmpresa(Integer.valueOf(chbEmpresas[i]));
                    }
                } else {
                    out.println("<p>Por favor, selecciona al menos una empresa para eliminar.</p>");
                }
            }
        %>
    </body>
</html>
