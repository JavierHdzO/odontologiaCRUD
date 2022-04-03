<%-- 
    Document   : register
    Created on : Apr 1, 2022, 8:25:54 PM
    Author     : Francisco Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.net.*, java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    </head>
    <body>
        <div class="container">
            <div class="row mt-5">
                <div class="col-md-4 mx-auto">
                    <div class="card">
                        <div class="card-header">
                            Cuenta de Registro
                        </div>
                        <div class="card-body">
                            <form action="/users/singup" method="POST">
                                <div class="form-group my-1">
                                    <input
                                        type="text"
                                        class="form-control"
                                        name="usuario"
                                        placeholder="Usuario"

                                        />
                                </div>

                                <div class="form-group my-1">
                                    <input
                                        type="text"
                                        class="form-control"
                                        name="nombre"
                                        placeholder="Nombre"

                                        />
                                </div>
                                <div class="form-group">
                                    <input
                                        type="password"
                                        class="form-control"
                                        name="password"
                                        placeholder="Contraseña"
                                        />
                                </div>

                                <div class="form-group my-1">
                                    <input
                                        type="password"
                                        class="form-control"
                                        name="confirm_password"
                                        placeholder="Confirmar Contraseña"
                                        />
                                </div>
                                <button class="btn btn-primary btn-block my-2" onclick="<%
                                    Connection con = null;
                                    ResultSet rs = null;
                                    Statement inst = null;
                                    CallableStatement cs = null;

                                    String strCon = "jdbc:mysql//localhost/odonto?user=root&password=password&PORT=3306";
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                                        con = DriverManager.getConnection(strCon);
                                        inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    } catch (java.lang.ClassNotFoundException e) {
                                    } catch (SQLException e) {
                                    };
                                    String param1 = request.getParameter("usuario");
                                    String param2 = request.getParameter("nombre");
                                    String param3 = request.getParameter("password");
                                    
                                        %>">
                                    Registrarte
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    </body>
</html>
