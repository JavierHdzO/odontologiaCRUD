<%-- 
    Document   : citas
    Created on : Apr 5, 2022, 1:26:09 PM
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
        <title>Administracion</title>

        <!--Bootstrap 5-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        <!--FONTS AWESOME-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
              integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">

        <!--Css styles-->

        <link  href="css/sidebars.css" rel="stylesheet" type="text/css">
        <link  href="css/mainCrud.css" rel="stylesheet" type="text/css">


    </head>
    <body>

        <nav class="navbar  navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="#">Odontologia</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">

                    <ul class="navbar-nav ms-auto">

                        <li class="nav-item">
                            <a class="nav-link" href='index.jsp?cerrar=true'>Cerrar Sesion</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <main>
            <div class="container-fluid ">
                <div class="row " id="divMain" >
                    <!-- <div class="col-3 bg-primary align-items-center " align="center">-->
                    <div class="col-3 m-0 bg-dark" id="slider">


                        <div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark"  id="slider2" style="width: 100%; ">
                            <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                                <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
                                <span class="fs-4">Administración</span>
                            </a>
                            <hr>
                            <ul class="nav nav-pills flex-column mb-auto">
                                <li class="nav-item">
                                    <a href="mainCrud.jsp" class="nav-link text-white" aria-current="page">
                                        <svg class="bi me-2" width="16" height="16"><use xlink:href="#home"/></svg>
                                        Medicos
                                    </a>
                                </li>
                                <li>
                                    <a href="mainPacientes.jsp" class="nav-link text-white">
                                        <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"/></svg>
                                        Pacientes
                                    </a>
                                </li>
                                <li>
                                    <a  class=" nav-link active">
                                        <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"/></svg>
                                        Citas
                                    </a>
                                </li>

                            </ul>
                            <hr>
                            <div class="dropdown">
                                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2">
                                    <strong><%                                        
                                        HttpSession sesion = request.getSession();
                                        String usuario;

                                        if (sesion.getAttribute("usr") != null) {
                                            usuario = sesion.getAttribute("usr").toString();

                                            out.print("<span>" + usuario + "</span>");
                                        } else {
                                            out.print("<script>location.replace('index.jsp') </script>");
                                        }


                                        %></strong>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href='index.jsp?cerrar=true'>Cerrar Sesión</a></li>
                                </ul>
                            </div>
                        </div>






                    </div>
                    <div class="col-9 my-3" >

                        <a class="btn btn-success mb-3 " type="button" id="btnAdd" data-bs-toggle="modal" data-bs-target="#exampleModal">Agregar</a>

                        <div class="tabScroll" align="center">
                            <%                                
                                    if (sesion.getAttribute("message") != null) {
                                    String mess = sesion.getAttribute("message").toString();
                                    if (mess.equals("Exito") || mess.equals("Cita_Eliminada") || mess.equals("Cita_agregada") || mess.equals("Cita_Actualizada") ) {
                                        out.print("<div class='alert alert-success alert-dismissible fade show' role='alert'>"
                                                + "<strong>" + mess + "</strong>"
                                                + "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>"
                                                + "</div>");
                                    } else {
                                        out.print("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                                                + "<strong>" + mess + "</strong>"
                                                + "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>"
                                                + "</div>");
                                    }
                                    sesion.removeAttribute("message");
                                }

                            %>

                            <%      if (sesion.getAttribute("message_up") != null) {

                                    String mess = sesion.getAttribute("message_up").toString();
                                    if (mess.equals("Usuario_Actualizado")) {
                                        out.print("<div class='alert alert-success alert-dismissible fade show' role='alert'>"
                                                + "<strong>" + mess + "</strong>"
                                                + "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>"
                                                + "</div>");
                                    } else if (mess.equals("Fallo_Actualizacion")) {
                                        out.print("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                                                + "<strong>" + mess + "</strong>"
                                                + "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>"
                                                + "</div>");
                                    }
                                    sesion.removeAttribute("message_up");
                                }

                            %>

                            <%                                
                                if (request.getParameter("btnSaveCita") != null) {
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

                                    int p_medID = Integer.parseInt(request.getParameter("medID").toString());
                                    String p_F = request.getParameter("Fecha");
                                    int p_Horario = Integer.parseInt(request.getParameter("Horario").toString());
                                    int p_pacienteID = Integer.parseInt(request.getParameter("pacienteID").toString());

                                    cs = con.prepareCall("{call sp_newCita(?,?,?,?)}");

                                    Date p_Fecha = Date.valueOf(p_F);

                                    cs.setInt(1, p_medID);
                                    cs.setDate(2, p_Fecha);
                                    cs.setInt(3, p_Horario);
                                    cs.setInt(4, p_pacienteID);

                                    String resu = "";

                                    try {
                                        rs = cs.executeQuery();

                                        if (rs != null) {
                                            rs.next();
                                            resu = rs.getString("Resultado");
                                            out.print("<p>" + resu + "</p>");
                                            if (!resu.isEmpty()) {

                                                sesion.setAttribute("message", resu);
                                                rs.close();
                                                con.close();
                                                response.sendRedirect("citas.jsp");
                                            }
                                        } else {
                                            sesion.setAttribute("message", "erro de ejecicion");
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

                            <%                                String d_ID = request.getParameter("delete");
                                if (d_ID != null) {
                                    Connection con = null;
                                    ResultSet rs = null;
                                    Statement inst = null;
                                    CallableStatement cs = null;
                                    try {

                                        String strCon = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
                                        String user = "root";
                                        String pass = "password";

                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        con = DriverManager.getConnection(strCon, user, pass);
                                        inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    } catch (ClassNotFoundException e) {
                                    }

                                    try {
                                        cs = con.prepareCall("{call sp_deleteCita(?)}");
                                        cs.setInt(1, Integer.parseInt(d_ID));

                                        rs = cs.executeQuery();

                                        if (rs != null) {
                                            rs.next();
                                            String resu = rs.getString("Resultado");

                                            sesion.setAttribute("message", resu);
                                            response.sendRedirect("citas.jsp");

                                        }

                                    } catch (SQLException e) {
                                        rs.close();
                                        cs.close();
                                        con.close();
                                    }
                                }

                            %>



                            <table class="table table-bordered">
                                <thead>
                                <th>ID</th>
                                <th>Medico</th>
                                <th>Fecha</th>
                                <th>Horario</th>
                                <th>Paciente</th>
                                <th>Editar</th>
                                <th>Elimiar</th>
                                </thead>
                                <tbody>

                                    <%                                        Connection con = null;
                                        ResultSet rs = null;
                                        Statement inst = null;
                                        CallableStatement cs = null;

                                        String strCon = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
                                        String user = "root";
                                        String pass = "password";

                                        try {
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            con = DriverManager.getConnection(strCon, user, pass);
                                            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                                            cs = con.prepareCall("{call sp_showCitas()}");
                                        } catch (ClassNotFoundException e) {
                                        }
                                        try {

                                            rs = cs.executeQuery();

                                            if (rs != null) {

                                                while (rs.next()) {
                                                    String ID = rs.getString("idHorario");
                                                    String NombreM = rs.getString("NombreM");
                                                    Date fecha = rs.getDate("Fecha");
                                                    int tel = rs.getInt("Horario");
                                                    String NombreP = rs.getString("NombreP");

                                                    //String fallo = rs.getString("Resultado");
%>


                                    <tr>
                                        <td><%=ID%></td>
                                        <td><%=NombreM%></td>
                                        <td><%=fecha%> </td>
                                        <td><%=tel + ""%></td>
                                        <td><%=NombreP%></td>
                                        <td align="center"> <a href="editarCita.jsp?id=<%=ID%>" class="far fa-edit buttonEdit"></a> </td>
                                        <td align="center"> <a href="citas.jsp?delete=<%=ID%> " type="submit" name="btnDeletMed" class="far fa-trash-alt buttonDelete"></a></td>
                                    </tr>
                                    <%
                                                }

                                            }
                                        } catch (SQLException e) {
                                            rs.close();
                                            cs.close();
                                            con.close();

                                        };
                                        rs.close();
                                        cs.close();
                                        con.close();

                                    %>

                                </tbody>
                            </table>

                        </div>

                    </div>
                </div>
            </div>
        </main>


        <!--Modal-->

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
                                    <%                                        con = null;
                                        rs = null;
                                        inst = null;
                                        cs = null;

                                        strCon = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
                                        user = "root";
                                        pass = "password";

                                        try {
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            con = DriverManager.getConnection(strCon, user, pass);
                                            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                                            cs = con.prepareCall("{call sp_showMedicos()}");
                                        } catch (ClassNotFoundException e) {
                                        }
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
                                            rs.close();
                                            cs.close();
                                            con.close();
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

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Horario</label>
                                <div class="col-sm-10">
                                    <input type="number" class="form-control" id="inputPassword" name="Horario" required>
                                </div>
                            </div>



                            <div class="mb-3 row">
                                <label for="inputSelected" class="col-sm-2 col-form-label">Paciente</label>
                                <select id="inputSelected" name="pacienteID" class="form-select form-select-sm mx-1" aria-label=".form-select-sm example">
                                    <option value="0" selected>Paciente No Seleccionado</option>
                                    <%                                        con = null;
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
                                <input type="submit" class="btn btn-primary" value="Guardar" name="btnSaveCita">
                            </div>
                        </form>



                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>
