<%-- 
    Document   : editarPaciente
    Created on : Apr 5, 2022, 4:17:35 AM
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
                    cs = con.prepareCall("{call sp_findPaciente(?)}");
                    int ID = Integer.parseInt(p_ID);
                    cs.setInt(1, ID);
                    rs = cs.executeQuery();

                    if (rs != null) {
                        while (rs.next()) {
                            if (ID == rs.getInt("NoAsig")) {
                                String p_Nombres = rs.getString("Nombres");
                                String p_Apellidos = rs.getString("Apellidos");
                                String p_calle = rs.getString("Calle");
                                String p_noc = rs.getString("Numero");
                                String p_colonia = rs.getString("Colonia");
                                int p_ciudad = rs.getInt("Ciudad");
                                int p_cp = rs.getInt("CP");
                                java.sql.Date p_nacimiento = rs.getDate("FechaNac");
                                String p_sexo = rs.getString("Sexo");
                                String p_Telefono = rs.getString("Telefono");


        %>



        <div  aria-labelledby="exampleModalLabel" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Editar paciente</h5>
                        <a type="button" class="btn-close"  href="mainPacientes.jsp" aria-label="Close"></a>
                    </div>
                    <div class="modal-body">
                        <form action="#" method="POST">

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Nombres</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="nombres"required value="<%=p_Nombres%>">
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Apellidos</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="apellidos" value="<%=p_Apellidos%>" required>
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Calle</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="calle" value="<%=p_calle%>" required >
                                </div>
                            </div>


                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Colonia</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="Colonia" value="<%=p_colonia%>"  required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Ciudad</label>
                                <div class="col-sm-10">
                                    <input type="number" class="form-control" id="inputPassword" name="Ciudad" value="<%=p_ciudad%>" required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputNo" class="col-sm-2 col-form-label">Numero</label>
                                <div class="col-sm-4">
                                    <input type="number" class="form-control" id="inputNo" name="noc" value="<%=p_noc%>" required >
                                </div>

                                <label for="inputCp" class="col-sm-2 col-form-label">CP</label>
                                <div class="col-sm-4">
                                    <input type="number" class="form-control" id="inputCp" name="cp"  value="<%=p_cp%>" required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Fecha N</label>
                                <div class="col-sm-4">
                                    <input type="date" class="form-control" id="inputPassword" name="nacimiento" value="<%=p_nacimiento.toString()%>" required >
                                </div>

                                <label for="inputSelected" class="col-sm-2 col-form-label">Sexo</label>
                                <select id="inputSelected" name="sexo" class="col-sm-4" aria-label=".form-select-sm example">
                                    <option value="M" selected>Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>

                             

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Telefono</label>
                                <div class="col-sm-10">
                                    <input type="tel" class="form-control" id="inputPassword" name="telefono" value="<%=p_Telefono%>" required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Foto</label>
                                <div class="col-sm-10">
                                    <input type="file" name="foto" accept="image/png, image/gif, image/jpeg, image/jpg" class="form-control" id="inputPassword" name="foto" >
                                </div>
                            </div>



                            <div class="modal-footer">
                                <a type="button" class="btn btn-secondary"  href="mainPacientes.jsp">Cerrar</a>
                                <input type="submit" class="btn btn-primary" value="Guardar" name="btnSavePaciente">
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
        
                     

        <%
                                out.print("<script>"
                                        + "var val = '" + p_sexo + "' ;"
                                        + "var sel = document.getElementById('inputSelected');"
                                        + "var opts = sel.options;"
                                        + "for (var opt, j = 0; opt = opts[j]; j++) {"
                                        + "if (opt.value == val) {"
                                        + "sel.selectedIndex = j;"
                                        + "console.log(j);"        
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
            if (request.getParameter("btnSavePaciente") != null) {

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
                cs = con.prepareCall("{call sp_updatePaciente(?,?,?,?,?,?,?,?,?,?,?,?)}");

                try {

                    operaciones ope = new operaciones();

                    int pa_ID = Integer.parseInt(request.getParameter("id"));
                    String p_Nombres = request.getParameter("nombres");
                    String p_Apellidos = request.getParameter("apellidos");
                    String p_calle = request.getParameter("calle");
                    String p_noc = request.getParameter("noc");
                    String p_colonia = request.getParameter("Colonia");
                    int p_ciudad = Integer.parseInt(request.getParameter("Ciudad"));
                    int p_cp = Integer.parseInt(request.getParameter("cp"));
                    java.sql.Date p_nacimiento = java.sql.Date.valueOf(request.getParameter("nacimiento"));
                    String p_sexo = request.getParameter("sexo");
                    String p_Telefono = request.getParameter("telefono");
                    
                    out.print("<p>"+request.getParameter("nacimiento")+"</p>");
                    
                    cs.setInt(1, pa_ID);
                    cs.setString(2, p_Nombres);
                    cs.setString(3, p_Apellidos);
                    cs.setString(4, p_calle);
                    cs.setString(5, p_noc);
                    cs.setString(6, p_colonia);
                    cs.setInt(7, p_ciudad);
                    cs.setInt(8, p_cp);
                    cs.setDate(9, p_nacimiento);
                    cs.setString(10, p_sexo);
                    cs.setString(11, p_Telefono);
                    cs.setString(12, null);

                    rs = cs.executeQuery();

                    String resul = "";
 

                    if (rs != null) {
                         out.print("<p> entre </p>");
                        while (rs.next()) {
                            resul = rs.getString("Resultado");
                             out.print("<p>" + resul + "</p>");
                            if (!resul.isEmpty()) {
                                 out.print("<p>" + p_ID + "</p>");
                                HttpSession sesion = request.getSession();
                                sesion.setAttribute("message_up", resul);
                                response.sendRedirect("mainPacientes.jsp");
                            }
                        }

                        con.close();
                    }

                } catch (SQLException e) {
                }

            }


        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>
