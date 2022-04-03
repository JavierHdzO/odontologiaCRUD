
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.net.*, java.sql.*"%>
<%@page import="modelado.operaciones"%>
<%@page session="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administracion</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Features</a>
                        </li>
                    </ul>


                    <ul class="navbar-nav ms-auto">

                        <li class="nav-item">
                            <a class="nav-link" href='index.jsp?cerrar=true'>Cerrar Sesion</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <main class="container-fluid main">
            <div class="container-fluid my-2">
                <div class="row ">
                    <div class="col-3 bg-primary align-items-center " align="center">

                        <div class="container align-items-end mx-5">
                            <img src="#" alt="Imagen de logo">
                        </div>

                        <h4>Usuario</h4>

                        <%
                            HttpSession sesion = request.getSession();
                            String usuario;

                            if (sesion.getAttribute("usr") != null) {
                                usuario = sesion.getAttribute("usr").toString();

                                out.print("<span>" + usuario + "</span>");
                            } else {
                                out.print("<script>location.replace('index.jsp') </script>");
                            }


                        %>


                    </div>
                    <div class="col-9 bg-secondary" align="center">
                        <h1>Contenido</h1>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>
