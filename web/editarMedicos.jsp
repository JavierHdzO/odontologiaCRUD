<%-- 
    Document   : editarMedicos
    Created on : Apr 4, 2022, 4:07:23 PM
    Author     : Francisco Ortiz
--%>

<%@page import="modelado.operaciones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@page import="java.io.*, java.net.*, java.sql.*"%>
<%@page import= "java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    </head>
    <body>

        <%
            String p_ID = request.getParameter("id");
            if (p_ID != null) {

                try {
                    Connection con = null;
                    ResultSet rs = null;
                    Statement inst = null;
                    CallableStatement cs = null;

                    String strCon = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
                    String user = "root";
                    String pass = "password";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(strCon, user, pass);

                    inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    cs = con.prepareCall("{call sp_findMedico(?)}");
                    int ID = Integer.parseInt(p_ID);
                    cs.setInt(1, ID);
                    rs = cs.executeQuery();

                    if (rs != null) {
                        while (rs.next()) {
                            if (ID == rs.getInt("ID")) {
                                String cedu = rs.getString("Cedula");
                                String names = rs.getString("Nombres");
                                String last_names = rs.getString("Apellidos");
                                String tel = rs.getString("Telefono");
                                int espe = rs.getInt("Especialidad");


        %>


        <div  aria-labelledby="exampleModalLabel" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Editar medico</h5>
                        <a type="button" class="btn-close" href="mainCrud.jsp" aria-label="Close"></a>
                    </div>
                    <div class="modal-body">
                        <form action="#" method="POST">
                            <div class="mb-3 row">
                                <label for="staticEmail" class="col-sm-2 col-form-label">Cédula</label>
                                <div class="col-sm-10">
                                    <input type="text" value="<%=cedu%>" class="form-control-plaintext" id="staticEmail" name="cedula" requiered>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Nombres</label>
                                <div class="col-sm-10">
                                    <input type="text" value="<%=names%>" class="form-control" id="inputPassword" name="nombres"required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Apellidos</label>
                                <div class="col-sm-10">
                                    <input type="text" value="<%=last_names%>" class="form-control" id="inputPassword" name="apellidos" required>
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Telefono</label>
                                <div class="col-sm-10">
                                    <input type="tel" value="<%=tel%>" class="form-control" id="inputPassword" name="telefono" required >
                                </div>
                            </div>


                            <div class="mb-3 row">


                                <label for="inputSelected" class="col-sm-2 col-form-label">Especialidad</label>
                                <select id="inputSelected" name="especialidad" class="form-select form-select-sm mx-1" aria-label=".form-select-sm example">
                                    <option value="1" selected>Cirujano Dentista</option>
                                    <option value="2">Ortodoncista</option>
                                    <option value="3">Ortopediatra</option>
                                    <option value="4">Dentista</option>
                                </select>


                            </div>




                            <div class="modal-footer">
                                <a type="button" class="btn btn-secondary" href="mainCrud.jsp">Cerrar</a>
                                <input type="submit" class="btn btn-primary" value="Guardar" name="btnUpdateMedico">
                            </div>
                        </form>



                    </div>

                </div>
            </div>
        </div>

        <%
                                out.print("<script>"
                                        + "var val =" + espe + " ;"
                                        + "var sel = document.getElementById('inputSelected');"
                                        + "var opts = sel.options;"
                                        + "for (var opt, j = 0; opt = opts[j]; j++) {"
                                        + "if (opt.value == val) {"
                                        + "sel.selectedIndex = j;"
                                        + "break;"
                                        + "}"
                                        + "}"
                                        + " </script>");
                            }
                        }
                    }
                } catch (SQLException e) {
                } catch (ClassNotFoundException e) {
                }

            } else {
                response.sendRedirect("mainCrud.jsp");
            }
        %>

        <%
            if (request.getParameter("btnUpdateMedico") != null) {

                try {

                    operaciones ope = new operaciones();

                    int pa_ID = Integer.parseInt(request.getParameter("id"));
                    String p_Cedula = request.getParameter("cedula");
                    String p_Nombres = request.getParameter("nombres");
                    String p_Apellidos = request.getParameter("apellidos");
                    String p_Telefono = request.getParameter("telefono");
                    int p_Especialidad = Integer.parseInt(request.getParameter("especialidad").toString());

                    String resu = ope.actualizarDoc(pa_ID, p_Cedula, p_Nombres, p_Apellidos, p_Telefono, p_Especialidad);

                    if (!resu.isEmpty()) {
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("message_up", resu);
                        response.sendRedirect("mainCrud.jsp");
                    }

                } catch (SQLException e) {
                }

            }


        %>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>
