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

    public boolean logIn(String Usrname, String pass) throws SQLException {
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
                    
                    if(usrRes.equals(Usrname) && pass.equals(passRes))
                    {
                        return true;
                    }
                }

                con.close();
            }

        } catch (SQLException e) {
        } catch (ClassNotFoundException ex) {
        }

        return false;

    }

}
