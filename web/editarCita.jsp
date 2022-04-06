<%-- 
    Document   : editarCita
    Created on : Apr 5, 2022, 3:54:28 PM
    Author     : Francisco Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.net.*, java.sql.*"%>
<%@page import="modelado.operaciones"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <main>
            <%
                Connection con = null;
                ResultSet rs = null;
                Statement inst = null;
                CallableStatement cs = null;

                String strCon = "";
                String user = "";
                String pass = "";


            %>
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Añadir nuevo cita</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="#" method="POST">
                                <div class="mb-3 row">
                                    <label for="inputSelected" class="col-sm-2 col-form-label">Medico</label>
                                    <select id="inputSelected" name="medID" class="form-select form-select-sm mx-1" aria-label=".form-select-sm example">
                                        <option value="0" selected>Medico No Seleccionado</option>
                                        <%                                            con = null;
                                            rs = null;
                                            inst = null;
                                            cs = null;

                                            strCon = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
                                            user = "root";
                                            pass = "password";

                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            con = DriverManager.getConnection(strCon, user, pass);
                                            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                                            cs = con.prepareCall("{call sp_showMedicos()}");

                                            try {

                                                rs = cs.executeQuery();

                                                if (rs != null) {

                                                    while (rs.next()) {
                                                        int ID = rs.getInt("ID");
                                                        String Nombres = rs.getString("Nombres");
                                                        String Apellidos = rs.getString("Apellidos");

                                        %>
                                        <option value="<%=ID%>" ><%= Nombres + " " + Apellidos%></option>

                                        <%
                                                    }

                                                    rs.close();
                                                    cs.close();
                                                    con.close();

                                                }
                                            } catch (SQLException e) {

                                            };


                                        %>
                                    </select>
                                </div>
                                <div class="mb-3 row">
                                    <label for="inputPassword" class="col-sm-2 col-form-label">Fecha</label>
                                    <div class="col-sm-10">
                                        <input type="date" class="form-control" id="inputPassword" name="Fecha"required >
                                    </div>
                                </div>

                                <!--Aqui se debe cambiar por un select-->
                                <!--Aqui se debe cambiar por un select-->
                                <%  %>    
                                <div class="mb-3 row">
                                    <label for="inputPassword" class="col-sm-2 col-form-label">Horario</label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="inputPassword" name="Horario" required>
                                    </div>
                                </div>
                                <%%>


                                <div class="mb-3 row">
                                    <label for="inputSelected" class="col-sm-2 col-form-label">Paciente</label>
                                    <select id="inputSelected" name="pacienteID" class="form-select form-select-sm mx-1" aria-label=".form-select-sm example">
                                        <option value="0" selected>Paciente No Seleccionado</option>
                                        <%                                        
                                            con = null;
                                            rs = null;
                                            inst = null;
                                            cs = null;

                                            strCon = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
                                            user = "root";
                                            pass = "password";

                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            con = DriverManager.getConnection(strCon, user, pass);
                                            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                                            cs = con.prepareCall("{call sp_showPaciente()}");

                                            try {

                                                rs = cs.executeQuery();

                                                if (rs != null) {

                                                    while (rs.next()) {
                                                        int ID = rs.getInt("NoAsig");
                                                        String Nombres = rs.getString("Nombres");
                                                        String Apellidos = rs.getString("Apellidos");

                                        %>

                                        <option value="<%=ID%>" ><%=Nombres + " " + Apellidos%></option>
                                        <%                }

                                                    rs.close();
                                                    cs.close();
                                                    con.close();

                                                }
                                            } catch (SQLException e) {

                                            };


                                        %>
                                    </select>
                                </div>




                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    <input type="submit" class="btn btn-primary" value="Guardar" name="btnSaveMedico">
                                </div>
                            </form>



                        </div>

                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
