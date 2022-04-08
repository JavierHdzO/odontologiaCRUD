/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelado;

import java.sql.*;
import java.net.*;
import java.io.*;
import static java.lang.System.out;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class operaciones {

    String Driver;
    String User;
    String Pass;
    String URL;

    public operaciones() {
        Driver = "com.mysql.cj.jdbc.Driver";
        User = "root";
        Pass = "password";
        URL = "jdbc:mysql://localhost:3306/odonto?zeroDateTimeBehavior=CONVERT_TO_NULL";
    }

    public int logIn(String Usrname, String pass) throws SQLException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;

        try {
            Class.forName(this.Driver);
            con = DriverManager.getConnection(this.URL, this.User, this.Pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_findUser(?,?)}");

            cs.setString(1, Usrname);
            cs.setString(2, pass);
            rs = cs.executeQuery();

            if (rs != null) {

                String usrRes = "";
                String passRes = "";
                while (rs.next()) {
                    usrRes = rs.getString("Login");
                    passRes = rs.getString("Password");
                    int usrID = rs.getInt("Clave");

                    if (usrRes.equals(Usrname) && pass.equals(passRes)) {
                        return usrID;
                    }
                }

                con.close();
            }

        } catch (SQLException e) {
        } catch (ClassNotFoundException ex) {
        }

        return 0;

    }

    public String guardarDoc(int pCedula, String pNombres, String pApellidos, String pTelefono, int pEspecialdad) throws SQLException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;
        String resul = "Fallo";
        try {
            Class.forName(this.Driver);
            con = DriverManager.getConnection(this.URL, this.User, this.Pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_newMedico(?,?,?,?,?)}");

            cs.setInt(1, pCedula);
            cs.setString(2, pNombres);
            cs.setString(3, pApellidos);
            cs.setString(4, pTelefono);
            cs.setInt(5, pEspecialdad);

            rs = cs.executeQuery();

            if (rs != null) {

                while (rs.next()) {
                    resul = rs.getString("Resultado");

                    if (resul.equals("Exito")) {
                        out.print("<p>" + resul + "</p>");
                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    } else {
                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    }
                }

                con.close();
            }

        } catch (SQLException | ClassNotFoundException e) {
        }

        return resul;

    }

    public String actualizarDoc(int pID, String pCedula, String pNombres, String pApellidos, String pTelefono, int pEspecialdad) throws SQLException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;
        String resul = "Fallo";
        try {
            Class.forName(this.Driver);
            con = DriverManager.getConnection(this.URL, this.User, this.Pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_updateMedico(?,?,?,?,?,?)}");

            cs.setInt(1, pID);
            cs.setString(2, pCedula);
            cs.setString(3, pNombres);
            cs.setString(4, pApellidos);
            cs.setString(5, pTelefono);
            cs.setInt(6, pEspecialdad);

            rs = cs.executeQuery();

            if (rs != null) {

                while (rs.next()) {
                    resul = rs.getString("Resultado");

                    if (resul.equals("Usuario_Actualizado")) {

                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    } else {
                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    }
                }

                con.close();
            }

        } catch (SQLException | ClassNotFoundException e) {
        }

        return resul;

    }

    public String deleteMed(int pID) throws SQLException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;
        String resul = "Fallo";
        try {
            Class.forName(this.Driver);
            con = DriverManager.getConnection(this.URL, this.User, this.Pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_deleteMedico(?)}");

            cs.setInt(1, pID);

            rs = cs.executeQuery();

            if (rs != null) {

                while (rs.next()) {
                    resul = rs.getString("Resultado");

                    if (resul.equals("Medico_Eliminado")) {
                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    }
                }

                con.close();
            }

        } catch (SQLException | ClassNotFoundException e) {
        }
        rs.close();
        cs.close();
        con.close();
        return resul;

    }

    public String guardarPac(String pNombres, String pApellidos, String pCalle, String pNumero, String pColonia, int pCiudad, int pCP, java.sql.Date pFec, String pSexo, String pTelefono, Object pFoto) throws SQLException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;
        String resul = "Fallo";
        try {
            Class.forName(this.Driver);
            con = DriverManager.getConnection(this.URL, this.User, this.Pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_newPaciente(?,?,?,?,?,?,?,?,?,?,?)}");

            cs.setString(1, pNombres);
            cs.setString(2, pApellidos);
            cs.setString(3, pCalle);
            cs.setString(4, pNumero);
            cs.setString(5, pColonia);
            cs.setInt(6, pCiudad);
            cs.setInt(7, pCP);
            cs.setDate(8, pFec);
            cs.setString(9, pSexo);
            cs.setString(10, pTelefono);
            cs.setString(11, null);

            //Registrado_Correctamente
            rs = cs.executeQuery();

            if (rs != null) {

                while (rs.next()) {
                    resul = rs.getString("Resultado");

                    if (resul.equals("Registrado_Correctamente")) {
                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    } else {
                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    }
                }

                con.close();
            }

        } catch (SQLException | ClassNotFoundException e) {
        }

        return resul;

    }

    public String deletePaciente(int pID) throws SQLException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;
        String resul = "Fallo";
        try {
            Class.forName(this.Driver);
            con = DriverManager.getConnection(this.URL, this.User, this.Pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_deletePaciente(?)}");

            cs.setInt(1, pID);

            rs = cs.executeQuery();

            if (rs != null) {

                while (rs.next()) {
                    resul = rs.getString("Resultado");

                    if (resul.equals("Paciente_Eliminado")) {
                        rs.close();
                        cs.close();
                        con.close();
                        return resul;
                    }
                }

                con.close();
            }

        } catch (SQLException | ClassNotFoundException e) {
        }
        rs.close();
        cs.close();
        con.close();
        return resul;

    }

    public String guardarCita(int idMedico, java.sql.Date pFecha, int pHorario, int idPaciente) throws SQLException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;
        String resul = "Fallo";
        try {
            Class.forName(this.Driver);
            con = DriverManager.getConnection(this.URL, this.User, this.Pass);
            inst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            cs = con.prepareCall("{call sp_newCita(?,?,?,?)}");

            cs.setInt(1, idMedico);
            cs.setDate(2, pFecha);
            cs.setInt(3, pHorario);
            cs.setInt(4, idPaciente);

            //Registrado_Correctamente
            rs = cs.executeQuery();

            if (rs != null) {

                while (rs.next()) {
                    resul = rs.getString("Resultado");

                    return resul;
                }

                con.close();
            }

        } catch (SQLException | ClassNotFoundException e) {
        }

        return resul;

    }

    public BufferedInputStream showImag(int id, HttpServletResponse response) throws SQLException, IOException {
        Connection con = null;
        ResultSet rs = null, rs2;
        Statement inst = null;
        CallableStatement cs = null;
        
        
        
        return null;
    }

}
