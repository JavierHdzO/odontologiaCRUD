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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

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

                int ID;
                int medID = 0;
                Date fecha = null;
                int horario = 0;
                int pacienteID = 0;
                int pID = 0;


            %>

            <%                pID = Integer.parseInt(request.getParameter("id"));

                if (request.getParameter("") != null) {
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

                    cs = con.prepareCall("{call sp_findCita(?)}");

                    cs.setInt(1, pID);
                    try {

                        rs = cs.executeQuery();

                        if (rs != null) {

                            while (rs.next()) {
                                ID = rs.getInt("ID");
                                medID = rs.getInt("MedicoId");
                                fecha = rs.getDate("Fecha");
                                horario = rs.getInt("Horario");
                                pacienteID = rs.getInt("IdPaciente");

                            }

                            rs.close();
                            cs.close();
                            con.close();

                        }
                    } catch (SQLException e) {

                    };
                }


            %>





            <div  aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Añadir nuevo cita</h5>
                            <a type="button" class="btn-close" href="citas.jsp" aria-label="Close"></a>
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
                                                        int paID = rs.getInt("ID");
                                                        String Nombres = rs.getString("Nombres");
                                                        String Apellidos = rs.getString("Apellidos");

                                        %>
                                        <option value="<%=paID%>" ><%= Nombres + " " + Apellidos%></option>

                                        <%
                                                    }

                                                    out.print("<script>"
                                                            + "var val = " + "" + " ;"
                                                            + "var sel = document.getElementById('inputSelected');"
                                                            + "var opts = sel.options;"
                                                            + "for (var opt, j = 0; opt = opts[j]; j++) {"
                                                            + "if (opt.value == val) {"
                                                            + "sel.selectedIndex = j;"
                                                            + "break;"
                                                            + "}"
                                                            + "}"
                                                            + " </script>");

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
                                        <input type="date" class="form-control" id="inputPassword" value=" " name="Fecha"required >
                                    </div>
                                </div>

                                <!--Aqui se debe cambiar por un select-->
                                <!--Aqui se debe cambiar por un select-->
                                <%%>    
                                <div class="mb-3 row">
                                    <label for="inputPassword" class="col-sm-2 col-form-label">Horario</label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="inputPassword" value="" name="Horario" required>
                                    </div>
                                </div>
                                <%%>


                                <div class="mb-3 row">
                                    <label for="inputSelected" class="col-sm-2 col-form-label">Paciente</label>
                                    <select id="inputSelected" name="pacienteID" class="form-select form-select-sm mx-1" aria-label=".form-select-sm example">
                                        <option value="0" selected>Paciente No Seleccionado</option>
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

                                            cs = con.prepareCall("{call sp_showPaciente()}");

                                            try {

                                                rs = cs.executeQuery();

                                                if (rs != null) {

                                                    while (rs.next()) {
                                                        int paID = rs.getInt("NoAsig");
                                                        String Nombres = rs.getString("Nombres");
                                                        String Apellidos = rs.getString("Apellidos");

                                        %>

                                        <option value="<%=paID%>" ><%=Nombres + " " + Apellidos%></option>
                                        <%                }

                                                    out.print("<script>"
                                                            + "var val = " + "" + " ;"
                                                            + "var sel = document.getElementById('inputSelected');"
                                                            + "var opts = sel.options;"
                                                            + "for (var opt, j = 0; opt = opts[j]; j++) {"
                                                            + "if (opt.value == val) {"
                                                            + "sel.selectedIndex = j;"
                                                            + "break;"
                                                            + "}"
                                                            + "}"
                                                            + " </script>");

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
                                    <a type="button" class="btn btn-secondary" href="citas.jsp">Cerrar</a>
                                    <input type="submit" class="btn btn-primary" value="Guardar" name="btnSaveMedico">
                                </div>
                            </form>



                        </div>

                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


    </body>
</html>
