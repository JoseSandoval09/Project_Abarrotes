<%-- 
    Document   : ModificarProveedor
    Created on : 23 oct. 2024, 19:47:40
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
    <title>Modificar Proveedor</title>
</head>
<body>
    <h1>Portal de modificación de datos del proveedor</h1>
    <% ProveedorDAO proveedorDAO = new ProveedorDAO();
        List<Proveedor> listaProveedores = proveedorDAO.obtenListaProveedor(); // Asegúrate de tener este método
    %>
    <form method="post">
        <CENTER>
            <HR> 
            <I>Para modificar un proveedor, selecciona en la columna final. <a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>
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
            <input type="submit" value="Actualizar seleccionado" name="actualizar" />
        </CENTER>
    </form>
    <%
        if (request.getParameter("actualizar") != null) {
            String[] chbProveedores = request.getParameterValues("cbactores");
            if (chbProveedores != null && chbProveedores.length > 0) {
                int idProveedor = Integer.valueOf(chbProveedores[0]); // Suponiendo que solo se selecciona un proveedor a la vez
                Proveedor proveedor = proveedorDAO.obtenProveedor(idProveedor); // Método para obtener el proveedor
    %>
                <h2>Modificar Proveedor</h2>
                <form method="post" action="ModificarProveedor.jsp">
                    <input type="hidden" name="idProveedor" value="<%= proveedor.getIdProveedor() %>" />
                    <table>
                        <tr>
                            <td><label for="nombreProveedor">Nombre Proveedor:</label></td>
                            <td><input type="text" id="nombreProveedor" name="nombreProveedor" value="<%= proveedor.getNombreProveedor() %>" required /></td>
                        </tr>
                        <tr>
                            <td><label for="apellPatProveedor">Apellido Paterno:</label></td>
                            <td><input type="text" id="apellPatProveedor" name="apellPatProveedor" value="<%= proveedor.getApellPatProveedor() %>" required /></td>
                        </tr>
                        <tr>
                            <td><label for="apellMatProveedor">Apellido Materno:</label></td>
                            <td><input type="text" id="apellMatProveedor" name="apellMatProveedor" value="<%= proveedor.getApellMatProveedor() %>" required /></td>
                        </tr>
                        <tr>
                            <td><label for="empresa">Empresa:</label></td>
                            <td><input type="text" id="empresa" name="empresa" value="<%= proveedor.getEmpresa() %>" required /></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="Actualizar Proveedor" />
                            </td>
                        </tr>
                    </table>
                </form>
    <%
            } else {
                out.println("<p>No se ha seleccionado ningún proveedor para modificar.</p>");
            }
        }
        
        // Si el formulario de actualización se envía
        if (request.getParameter("idProveedor") != null) {
            Integer idProveedor = Integer.valueOf(request.getParameter("idProveedor"));
            String nombreProveedor = request.getParameter("nombreProveedor");
            String apellPatProveedor = request.getParameter("apellPatProveedor");
            String apellMatProveedor = request.getParameter("apellMatProveedor");
            String empresa = request.getParameter("empresa");

            Proveedor proveedor = new Proveedor();
            proveedor.setIdProveedor(idProveedor);
            proveedor.setNombreProveedor(nombreProveedor);
            proveedor.setApellPatProveedor(apellPatProveedor);
            proveedor.setApellMatProveedor(apellMatProveedor);
            proveedor.setEmpresa(empresa);

            proveedorDAO.actualizaProveedor(proveedor); // Método para actualizar el proveedor en el DAO

            out.println("<p>Proveedor actualizado exitosamente.</p>");
        }
    %>
</body>
</html>
