<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.net.*, java.sql.*"%>
<%@page import= "java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>

<%@page import="javax.servlet.http.*,javax.servlet.*"%>





<%
    String a = request.getParameter("usuario");
    String b = request.getParameter("password");
    String c = request.getParameter("nombre");
    //String a = request.getParameter("usuario");
    if (a != null && b != null && c != null) {
        if (!a.isEmpty() && !b.isEmpty() && !c.isEmpty()) {
            Connection con = null;
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
                cs = con.prepareCall("{call sp_newUser(?,?,?,?)}");
            } catch (ClassNotFoundException e) {
            }
            String param1 = request.getParameter("usuario");
            String param2 = request.getParameter("password");
            String param3 = request.getParameter("nombre");
            String param4 = request.getParameter("apellidos");
            String param5 = request.getParameter("password_conf");

            param3 = param3 + " " + param4;

            //String query = "INSERT INTO usuarios(Login, Password, Nombre, foto) VALUES( '" + param1 + "','" + param2 + "','" + param3 + "', '');";
            if (param2.equals(param5)) {
                try {

                    cs.setString(1, param1);
                    cs.setString(2, param2);
                    cs.setString(3, param3);
                    cs.setObject(4, null);
                    rs = cs.executeQuery();

                    /*
                    while (rs.next()) {
                        out.print("<a>" + rs.getString(1).toString() + "</a>");
                    }
                    */
                        rs.close();
                        con.close();
                        response.sendRedirect("index.jsp");
                    //out.print("<script>location.replace('index.jsp') </script>");
                    
                } catch (SQLException e) {
                    rs.close();
                    cs.close();
                    con.close();
                }

            } else {
                out.print("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                        + "<strong>Contraseña no coincide</strong>"
                        + "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>"
                        + "</div>");
            }

            //out.print("<a>" + param1 + "</a>");
            a = null;
            b = null;
            c = null;

        }
    }
%>
<html>
    <head>
        <title>Sign In</title>
        <!--Boostrap 5-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        <!--Css stylesheet-->
        <link href="css/register.css" rel="stylesheet">
    </head>
    <body>

        <main class="container col-12">
            <div class= "container container-fluid mt-5">
                <form action="#" method="POST" class="form-registro">

                    <div class="row">
                        <div class="col">
                            <label>Nombre</Label>
                            <input  type="text" class="form-control" name="nombre" placeholder="Nombres" required>
                        </div>
                        <div class="col">
                            <label>Apellidos</label>
                            <input  type="text" class="form-control" name="apellidos" ID="txtBox_apellidos" placeholder="Apellidos" required>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col">
                            <label>Contraseña</label>
                            <input type="password" name="password" class="form-control"  placeholder="Contraseña" required>
                        </div>
                        <div class="col">
                            <label>Confirma tu contraseña</label>
                            <input type="password" class="form-control"  name="password_conf" placeholder="Confirma tu contraseña" required>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class=" col">
                            <label>Usuario</label>
                            <input type="text" class="form-control" name="usuario" placeholder="Usuario" required>
                        </div>
                    </div>


                    <div class="row mt-3" >
                        <div class="col">
                            <label for="formFile" class="form-label">Imagen de perfil</label>
                            <input name="poto" class="form-control" type="file" id="formFile">
                        </div>
                    </div>

                    <div class="form-group my-2">
                        <center>
                            <a href="index.jsp"> Ya estoy registrado </a>
                        </center>
                    </div>
                    <center>

                        <input type="submit" class="btn btn-primary btn-block" name="name">
                    </center>
                </form>
            </div>

        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>