<%-- 
    Document   : InsertarProveedor
    Created on : 23 oct. 2024, 19:27:08
    Author     : josee
--%>

<%-- 
    Document   : InsertarProveedor
    Created on : 23/10/2024
    Author     : Search
--%>
<%@page import="Mapeos.Proveedor"%>
<%@page import="Beans.ProveedorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insertar Proveedor</title>
</head>
<body>
    <h1>Formulario de Inserción de Proveedor</h1>
    <form method="post">
        <table>
            <tr>
                <td><label for="nombreProveedor">Nombre Proveedor:</label></td>
                <td><input type="text" id="nombreProveedor" name="nombreProveedor" required /></td>
            </tr>
            <tr>
                <td><label for="apellPatProveedor">Apellido Paterno:</label></td>
                <td><input type="text" id="apellPatProveedor" name="apellPatProveedor" required /></td>
            </tr>
            <tr>
                <td><label for="apellMatProveedor">Apellido Materno:</label></td>
                <td><input type="text" id="apellMatProveedor" name="apellMatProveedor" required /></td>
            </tr>
            <tr>
                <td><label for="empresa">Empresa:</label></td>
                <td><input type="text" id="empresa" name="empresa" required /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="Insertar Proveedor" />
                </td>
            </tr>
        </table>
        <a href="EliminarProveedor.jsp">Regresar</a>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String nombreProveedor = request.getParameter("nombreProveedor");
            String apellPatProveedor = request.getParameter("apellPatProveedor");
            String apellMatProveedor = request.getParameter("apellMatProveedor");
            String empresa = request.getParameter("empresa"); // Aquí obtienes la empresa

            Proveedor proveedor = new Proveedor();
            proveedor.setNombreProveedor(nombreProveedor);
            proveedor.setApellPatProveedor(apellPatProveedor);
            proveedor.setApellMatProveedor(apellMatProveedor);
            proveedor.setEmpresa(empresa); // Asocia la empresa seleccionada
            
            ProveedorDAO proveedorDAO = new ProveedorDAO();
            int idGenerado = proveedorDAO.guardarProveedor(proveedor); // Método que deberías tener en tu ProveedorDAO

            if (idGenerado > 0) {
                out.println("<p>Proveedor insertado exitosamente con ID: " + idGenerado + "</p>");
            } else {
                out.println("<p>Error al insertar el proveedor.</p>");
            }
        }
    %>
</body>
</html>
