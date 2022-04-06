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

        <!-- Css styles-->
        <link href="css/editables.css" rel="stylesheet">
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

                HttpSession sesion = request.getSession();


            %>







            <div  aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content formulario">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Añadir nuevo cita</h5>
                            <a type="button" class="btn-close" href="citas.jsp" aria-label="Close"></a>
                        </div>
                        <div class="modal-body">
                            <form action="#" method="POST"> 
                                <div class="mb-3 row col-sm-12">
                                    <label for="inputSelected" class="col-sm-2 col-form-label"><strong>Medico</strong></label>
                                    <select id="inputSelected" name="medID" class="form-select form-select-sm mx-1" aria-label=".form-select-sm example">
                                        <option value="0" selected>Medico No Seleccionad</option>
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




                                <%                                    
                                    String parID = request.getParameter("id");

                                    if (parID != null) {
                                        pID = Integer.parseInt(request.getParameter("id"));
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
                                                    ID = rs.getInt("idHorario");
                                                    medID = rs.getInt("MedicoId");
                                                    fecha = rs.getDate("Fecha");
                                                    horario = rs.getInt("Horario");
                                                    pacienteID = rs.getInt("IdPaciente");

                                %>
                                <div class="mb-3 row">
                                    <label for="inputPassword" class="col-sm-2 col-form-label"><strong>Fecha</strong></label>
                                    <div class="col-sm-10">
                                        <input type="date" class="form-control" id="inputPassword" value="<%= fecha.toString()%>" name="Fecha"required >
                                    </div>
                                </div>

                                <!--Aqui se debe cambiar por un select-->
                                <!--Aqui se debe cambiar por un select-->

                                <div class="mb-3 row">
                                    <label for="inputPassword" class="col-sm-2 col-form-label"><strong>Horario</strong></label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="inputPassword" value="<%=horario%>" name="Horario" required>
                                    </div>
                                </div>

                                <%
                                                }

                                                rs.close();
                                                cs.close();
                                                con.close();

                                            }
                                        } catch (SQLException e) {

                                        };
                                    }


                                %>
                                <div class="mb-3 row col-sm-12"> 
                                    <label for="inputSelected2" class="col-sm-2 col-form-label"><strong>Paciente </strong></label>
                                    <select id="inputSelected2" name="pacienteID" class="form-select form-select-sm mx-1" aria-label=".form-select-sm example" >
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


                                <script>
                                    var val = <%=medID%>;
                                    var sel = document.getElementById('inputSelected');
                                    var opts = sel.options;
                                    for (var opt, j = 0; opt = opts[j]; j++) {
                                        if (opt.value == val) {
                                            sel.selectedIndex = j;
                                            break;
                                        }
                                    }

                                    val = <%=pacienteID%>;
                                    sel = document.getElementById('inputSelected2');
                                    opts = sel.options;
                                    for (var opt, j = 0; opt = opts[j]; j++) {
                                        if (opt.value == val) {
                                            sel.selectedIndex = j;
                                            break;
                                        }
                                    }
                                </script>


                                <div class="modal-footer">
                                    <a type="button" class="btn btn-secondary" href="citas.jsp">Cerrar</a>
                                    <input type="submit" class="btn btn-primary" value="Guardar" name="btnUpdateCita">
                                </div>
                            </form>

                            <%
                                if (request.getParameter("btnUpdateCita") != null) {
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

                                    int p_medID = Integer.parseInt(request.getParameter("medID").toString());
                                    String p_F = request.getParameter("Fecha");
                                    int p_Horario = Integer.parseInt(request.getParameter("Horario").toString());
                                    int p_pacienteID = Integer.parseInt(request.getParameter("pacienteID").toString());

                                    cs = con.prepareCall("{call sp_updateCita(?,?,?,?,?)}");

                                    Date p_Fecha = Date.valueOf(p_F);
                                    
                                    cs.setInt(1, pID);
                                    cs.setInt(2, p_medID);
                                    cs.setDate(3, p_Fecha);
                                    cs.setInt(4, p_Horario);
                                    cs.setInt(5, p_pacienteID);

                                    String resu = "";

                                    try {
                                        rs = cs.executeQuery();

                                        if (rs != null) {
                                            rs.next();
                                            resu = rs.getString("Resultado");

                                            if (!resu.isEmpty()) {

                                                sesion.setAttribute("message", resu);
                                                rs.close();
                                                con.close();
                                                response.sendRedirect("citas.jsp");
                                            }
                                        } else {
                                            sesion.setAttribute("message", "error de ejecicion");
                                            response.sendRedirect("citas.jsp");
                                        }
                                    } catch (SQLException e) {
                                        rs.close();
                                        cs.close();
                                        con.close();
                                    }
                                    rs.close();
                                    con.close();
                                }

                            %>

                        </div>

                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


    </body>
</html>
