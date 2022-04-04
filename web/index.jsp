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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <body>

        <main class="container col-12">
            <div class="row mt-4">
                <div class="col-md-4 mx-auto">
                    <div class="card" id="formContainer">
                        <div class="card-header" style="color:white; background-color: #58afe5; border-color: #005eff;">
                            Account Login
                        </div>

                        <img src="/img/logoUAT.png" alt="Logo" class="rounded-circle mx-auto d-block m-4 logo">

                        <div class= "card-body">
                            <form action="#" method="POST">
                                <div class="form-group my-1">
                                    <input type="text" class="form-control" name="usuario" placeholder="Usuario" required />
                                </div>
                                <div class="form-group my-1">
                                    <input type="password" class="form-control" name="password" placeholder="Contraseña" required/>
                                </div>
                                <div class="form-group my-2">
                                    <center>
                                        <a href="prueba.jsp"> Registrarme </a>
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

                                    boolean rs = ope.logIn(usrName, pass);

                                    if (rs) {
                                        HttpSession sesion = request.getSession();
                                        sesion.setAttribute("usr", usrName);
                                        response.sendRedirect("mainCrud.jsp");
                                    } else {
                                        response.sendRedirect("index.jsp");
                                    }

                                }

                                if (request.getParameter("cerrar") != null) {
                                    if (request.getParameter("cerrar").equals("true")) {
                                        session.invalidate();
                                    }
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
