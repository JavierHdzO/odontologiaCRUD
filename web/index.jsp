<%-- 
    Document   : index
    Created on : Apr 1, 2022, 8:17:55 PM
    Author     : Francisco Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.net.*, java.sql.*"%>
<%@page import="modelado.operaciones"%>
<%@page session="true" %>

<html lang="en">
    <head>
        <title>Index</title>
        <!--Boostrap 5-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <!-- CSS styles  -->
        <link href="css/login.css" rel="stylesheet">
    </head>
    <body class="Background">

            <div class= "container container-fluid mt-5" align="center">
                
                <form action="#" method="POST" class="form-login">
                    <img src="img/logo.png"  class="img-fluid" ID="logoOdontología" alt="logo odontologia">
                    <div class="form-group mt-3 my-1">
                        <input type="text" class="form-control" name="usuario" placeholder="Usuario" required />
                    </div>
                    <div class="form-group mt-3 my-1">
                        <input type="password" class="form-control" name="password" placeholder="Contraseña" required/>
                    </div>
                    <div class="form-group my-2">
                        <center>
                            <a href="prueba.jsp"> ¿No tienes una cuenta? </a>
                        </center>
                    </div>
                    <center>

                        <input type="submit" class="btn btn-primary btn-block my-2 " name="btnIngresar"   value="Iniciar Sesión"/>

                    </center>
                </form>

                <%

                    operaciones ope = new operaciones();

                    if (request.getParameter("btnIngresar") != null) {
                        String usrName = request.getParameter("usuario");
                        String pass = request.getParameter("password");
                        
                       

                        int rs = ope.logIn(usrName, pass);

                        if (rs != 0) {
                            HttpSession sesion = request.getSession();
                            
                            sesion.setAttribute("usr", usrName);
                            sesion.setAttribute("usrID", rs);
                            response.sendRedirect("mainCrud.jsp");
                        } else {
                            response.sendRedirect("index.jsp");
                        }

                    }

                    if (request.getParameter("cerrar") != null) {
                        if (request.getParameter("cerrar").equals("true")) {
                            response.sendRedirect("index.jsp");
                            session.invalidate();
                        }
                    }

                %>

            </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>
