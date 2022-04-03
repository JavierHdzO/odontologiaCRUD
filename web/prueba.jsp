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

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(strCon, user, pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_newUser2(?,?,?,?)}");

            String param1 = request.getParameter("usuario");
            String param2 = request.getParameter("password");
            String param3 = request.getParameter("nombre");

            
            //String query = "INSERT INTO usuarios(Login, Password, Nombre, foto) VALUES( '" + param1 + "','" + param2 + "','" + param3 + "', '');";

            try {

                cs.setString(1, param1);
                cs.setString(2, param2);
                cs.setString(3, param3);
                cs.setObject(4, null);
                rs = cs.executeQuery();

                while(rs.next())
                {  
                   out.print("<a>" + rs.getString(1).toString() + "</a>");
                }
               
                out.print("<script>location.replace('index.jsp') </script>");
                con.close();
            } catch (SQLException e) {

            };

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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    </head>
    <body>

        <main class="container col-12">
            <div class="row mt-4">
                <div class="col-md-4 mx-auto">
                    <div class="card" id="formContainer">
                        <div class="card-header" style="color:white; background-color: #58afe5; border-color: #005eff;">
                            Registro
                        </div>

                        <img src="/img/logoUAT.png" alt="Logo" class="rounded-circle mx-auto d-block m-4 logo">

                        <div class= "card-body">
                            <form action="#" method="POST">
                                <div class="form-group my-1">
                                    <input type="text" class="form-control" name="usuario" placeholder="Usuario" />
                                </div>
                                <div class="form-group my-1">
                                    <input type="text" class="form-control" name="nombre" placeholder="Nombre" />
                                </div>

                                <div class="form-group my-1">
                                    <input type="password" class="form-control" name="password" placeholder="Contraseña" />
                                </div>

                                <div class="form-group my-1">
                                    <input type="password" class="form-control" name="password_conf" placeholder="Confirmar contraseña" />
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
                    </div>
                </div>
            </div>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>