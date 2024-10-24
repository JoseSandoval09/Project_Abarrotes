<%-- 
    Document   : ModificarEmpresa
    Created on : 23 oct. 2024, 18:38:00
    Author     : josee
--%>

<%@page import="Mapeos.Empresa"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EmpresaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Empresa</title>
    </head>
    <body>
        <h1>Portal de modificación de datos de la empresa</h1>
        <%
            EmpresaDAO empresaDAO = new EmpresaDAO();
            List<Empresa> listaEmpresas = empresaDAO.obtenListaEmpresas();
            int valor = 0;
        %>
        <form>
            <CENTER>
                <HR>
                <I>Para modificar una empresa, selecciona las filas que deseas modificar. <a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>
                </HR>
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID Empresa</th>
                            <th>Nombre Empresa</th>
                            <th>Razón Social</th>
                            <th>Giro</th>
                        </tr>
                    </thead>
                    <%  for (Empresa empresa : listaEmpresas) {
                    %>
                    <tr>
                        <td><%= empresa.getIdEmpresa() %></td>
                        <td><%= empresa.getNombreEmpresa() %></td>
                        <td><%= empresa.getRazonSocial() %></td>
                        <td><%= empresa.getGiro() %></td>
                        <td><input type="checkbox" name="cbempresas" value="<%= empresa.getIdEmpresa() %>" /></td>
                    </tr>
                    <%
                        valor = empresa.getIdEmpresa().intValue();
                    }
                    %>
                </table>
                <input type="submit" value="Actualizar seleccionado" name="actualizar" />
                <a href="EliminarEmpresa.jsp">Regresar</a>
                <%
                    if ((request.getParameter("actualizar") != null)) {
                %>
                <h2>Modificar empresa</h2>
                <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25%">
                    <jsp:useBean id="empresa" scope="page" class="Mapeos.Empresa" />
                    <jsp:setProperty name="empresa" property="*" />
                    <%
                        String[] chbEmpresas = request.getParameterValues("cbempresas");
                        for (int i = 0; i <= chbEmpresas.length; i++) {
                            if (i == chbEmpresas.length) {
                    %>
                    <tr>
                        <td>
                            <input id="NombreEmpresa" name="nombreEmpresa" placeholder="Nombre de la Empresa"
                                   title="Nombre de la Empresa" type="text" value="<%= listaEmpresas.get(i - 1).getNombreEmpresa() %>" size="25" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RazonSocial" name="razonSocial" placeholder="Razón Social"
                                   title="Razón Social" type="text" value="<%= listaEmpresas.get(i - 1).getRazonSocial() %>" size="25" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Giro" name="giro" placeholder="Giro"
                                   title="Giro" type="text" value="<%= listaEmpresas.get(i - 1).getGiro() %>" size="25" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="submit" name="submit" type="submit" value="Actualizar">
                            <input type="reset" value="Limpiar">
                        </td>
                    </tr>
                </table>
            </CENTER>
        </form>
        <%
                            }
                        }
                    }
                %>
    </body>
</html>
