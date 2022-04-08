
<%@page import="java.util.Base64"%>
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
        <%
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("usr") == null) {

                response.sendRedirect("index.jsp");
            }

        %>


        <%                    sesion = request.getSession();
            int usrID = Integer.parseInt(sesion.getAttribute("usrID").toString());

            Connection con = null;
            ResultSet rs = null;
            Statement inst = null;
            CallableStatement cs = null;

            String strCon = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
            String user = "root";
            String pass = "password";

            String base64Image = "";

            InputStream foto = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(strCon, user, pass);
                cs = con.prepareCall("{call sp_getPhotoUser(?)}");
                cs.setInt(1, usrID);

            } catch (ClassNotFoundException e) {
            }

            try {

                rs = cs.executeQuery();
                if (rs.next()) {
                    Blob blob = rs.getBlob("foto");

                    foto = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = foto.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    foto.close();
                    outputStream.close();

                    rs.close();

                }
            } catch (SQLException E) {
            }


        %>


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
                                    <a href="mainCrud.jsp" class="nav-link text-white" >
                                        <svg class="bi me-2" width="16" height="16"><use xlink:href="#home"/></svg>
                                        Medicos
                                    </a>
                                </li>
                                <li>
                                    <a  class="nav-link  active" aria-current="page">
                                        <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"/></svg>
                                        Pacientes
                                    </a>
                                </li>
                                <li>
                                    <a href="citas.jsp" class="nav-link text-white">
                                        <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"/></svg>
                                        Citas
                                    </a>
                                </li>

                            </ul>
                            <hr>
                            <div class="dropdown">
                                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                                    <%if (!base64Image.isEmpty()){ %>
                                    
                                    <img src="data:image/png;base64,<%=base64Image%>" alt="" width="32" height="32" class="rounded-circle me-2">
                                    
                                    <%} else {%>
                                        <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2">
                                    <% }%>
                                    <strong><%                                        sesion = request.getSession();
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

                        <div  class="tabScroll" align="center">
                            <%                                if (sesion.getAttribute("message") != null) {
                                    String mess = sesion.getAttribute("message").toString();
                                    if (mess.equals("Exito") || mess.equals("Medico_Eliminado") || mess.equals("Registrado_Correctamente") || mess.equals("Paciente_Eliminado")) {
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
                                    if (mess.equals("Usuario_Actualizado") || mess.equals("Paciente_Actualizado")) {
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

                            <%                                if (request.getParameter("btnSaveMedico") != null) {
                                    operaciones ope = new operaciones();

                                    String p_Nombres = request.getParameter("nombres");
                                    String p_Apellidos = request.getParameter("apellidos");
                                    String p_calle = request.getParameter("calle");
                                    String p_noc = request.getParameter("noc");
                                    String p_colonia = request.getParameter("Colonia");
                                    int p_ciudad = Integer.parseInt(request.getParameter("Ciudad"));
                                    int p_cp = Integer.parseInt(request.getParameter("cp"));
                                    Date p_nacimiento = Date.valueOf(request.getParameter("nacimiento"));
                                    String p_sexo = request.getParameter("sexo");
                                    String p_Telefono = request.getParameter("telefono");

                                    //String p_foto = request.getParameter("foto");
                                    //String p_calle = request.getParameter("foto");
                                    String resu = ope.guardarPac(p_Nombres, p_Apellidos, p_calle, p_noc, p_colonia, p_ciudad, p_cp, p_nacimiento, p_sexo, p_Telefono, null);

                                    if (!resu.isEmpty()) {

                                        sesion.setAttribute("message", resu);
                                        response.sendRedirect("mainPacientes.jsp");
                                    }

                                }

                            %>

                            <%                                String d_ID = request.getParameter("delete");
                                if (d_ID != null) {

                                    operaciones ope = new operaciones();

                                    String resu = ope.deletePaciente(Integer.parseInt(d_ID));

                                    if (!resu.isEmpty()) {

                                        sesion.setAttribute("message", resu);
                                        response.sendRedirect("mainPacientes.jsp");
                                    }

                                }

                            %>



                            <table class="table table-bordered">
                                <thead>
                                <th>NoAsig</th>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                                <th>Calle</th>
                                <th>Numero</th>
                                <th>Colonia</th>
                                <th>Ciudad</th>
                                <th>CP</th>
                                <th>FechaNac</th>
                                <th>Sexo</th>
                                <th>Telefono</th>
                                <th>Foto</th>
                                <th>Editar</th>
                                <th>Elimiar</th>
                                </thead>
                                <tbody>

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
                                                    String names = rs.getString("Nombres");
                                                    String last_names = rs.getString("Apellidos");
                                                    String add = rs.getString("Calle");
                                                    String no = rs.getString("Numero");
                                                    String colonia = rs.getString("Colonia");
                                                    int ciudad = rs.getInt("Ciudad");
                                                    int cp = rs.getInt("CP");
                                                    Date fecha = rs.getDate("FechaNac");
                                                    String sexo = rs.getString("Sexo");
                                                    String tel = rs.getString("Telefono");

                                                    //String fallo = rs.getString("Resultado");
%>


                                    <tr>
                                        <td><%=ID%></td>
                                        <td><%=names%></td>
                                        <td><%=last_names%></td>
                                        <td><%=add%></td>
                                        <td><%=no%></td>
                                        <td><%=colonia%></td>
                                        <td><%=ciudad%></td>
                                        <td><%=cp%></td>
                                        <td><%=fecha%></td>
                                        <td><%=sexo%></td>
                                        <td><%=tel%></td>
                                        <td>Foto</td>
                                        <td align="center"> <a href="editarPaciente.jsp?id=<%=ID%>" class="far fa-edit buttonEdit"></a> </td>
                                        <td align="center"> <a href="mainPacientes.jsp?delete=<%=ID%> " type="submit" name="btnDeletMed" class="far fa-trash-alt buttonDelete"></a></td>
                                    </tr>
                                    <%
                                                }

                                                rs.close();
                                                cs.close();
                                                con.close();

                                            }
                                        } catch (SQLException e) {

                                        };

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
                        <h5 class="modal-title" id="exampleModalLabel">Añadir nuevo paciente</h5>
                        <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="#" method="POST">

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Nombres</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="nombres"required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Apellidos</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="apellidos" required>
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Calle</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="calle" required >
                                </div>
                            </div>


                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Colonia</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPassword" name="Colonia" required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Ciudad</label>
                                <div class="col-sm-10">
                                    <input type="number" class="form-control" id="inputPassword" name="Ciudad" required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputNo" class="col-sm-2 col-form-label">Numero</label>
                                <div class="col-sm-4">
                                    <input type="number" class="form-control" id="inputNo" name="noc" required >
                                </div>

                                <label for="inputCp" class="col-sm-2 col-form-label">CP</label>
                                <div class="col-sm-4">
                                    <input type="number" class="form-control" id="inputCp" name="cp" required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Fecha N</label>
                                <div class="col-sm-4">
                                    <input type="date" class="form-control" id="inputPassword" name="nacimiento" required >
                                </div>

                                <label for="inputSelected" class="col-sm-2 col-form-label">Sexo</label>
                                <select id="inputSelected" name="sexo" class="col-sm-4" aria-label=".form-select-sm example">
                                    <option value="M" selected>Masculino</option>
                                    <option value="F">Femenino</option>
                                    <option value="B">Binario</option>
                                </select>
                            </div>



                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Telefono</label>
                                <div class="col-sm-10">
                                    <input type="tel" class="form-control" id="inputPassword" name="telefono" required >
                                </div>
                            </div>

                            <div class="mb-3 row">
                                <label for="inputPassword" class="col-sm-2 col-form-label">Foto</label>
                                <div class="col-sm-10">
                                    <input type="file" name="foto" accept="image/png, image/gif, image/jpeg, image/jpg" class="form-control" id="inputPassword" name="foto" >
                                </div>
                            </div>



                            <div class="modal-footer">
                                <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                <input type="submit" class="btn btn-primary" value="Guardar" name="btnSaveMedico">
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>
