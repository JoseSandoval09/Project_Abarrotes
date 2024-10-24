<%-- 
    Document   : EliminarProveedor
    Created on : 23 oct. 2024, 19:41:02
    Author     : josee
--%>

<%@page import="Mapeos.Proveedor"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProveedorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Proveedor</title>
</head>
<body>
    <h1>Portal de información del proveedor</h1>
    <% ProveedorDAO proveedorDAO = new ProveedorDAO();
        List<Proveedor> listaProveedores = proveedorDAO.obtenListaProveedor(); // Asegúrate de tener este método
    %>
    <form method="post">
        <HR> 
        <I>Para eliminar un proveedor, seleccionarlo en la columna final. <a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>
        </HR>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Proveedor</th>
                    <th>Nombre Proveedor</th>
                    <th>Apellido Paterno</th>
                    <th>Apellido Materno</th>
                    <th>Empresa</th>
                    <th>Seleccionar</th>
                </tr>
            </thead>
            <tbody>
                <% for (Proveedor p : listaProveedores) { %>
                <tr>
                    <td><%= p.getIdProveedor() %></td>
                    <td><%= p.getNombreProveedor() %></td>
                    <td><%= p.getApellPatProveedor() %></td>
                    <td><%= p.getApellMatProveedor() %></td>
                    <td><%= p.getEmpresa() %></td>
                    <td><input type="checkbox" name="cbactores" value="<%= p.getIdProveedor() %>"/></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <input type="submit" value="Eliminar Seleccionados" name="eliminar" />
        <input type="button" onclick="location.href='InsertarProveedor.jsp'" value="Insertar Proveedor" />
        <input type="button" onclick="location.href='ModificarProveedor.jsp'" value="Modificar Proveedor" />
    </form>
    <%
        if (request.getParameter("eliminar") != null) {
            String[] chbProveedores = request.getParameterValues("cbactores");
            if (chbProveedores != null) {
                for (String id : chbProveedores) {
                    proveedorDAO.eliminaProveedor(Integer.valueOf(id)); // Asegúrate de tener este método en tu DAO
                    out.println("<p>Proveedor con ID " + id + " ha sido eliminado.</p>");
                }
            } else {
                out.println("<p>No se ha seleccionado ningún proveedor para eliminar.</p>");
            }
        }
    %>
</body>
</html>
