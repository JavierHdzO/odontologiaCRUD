/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pxkService;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Olga Mares
 */
@WebService(serviceName = "ServiceWeb")
public class ServiceWeb {

    /**
     * Web service operation
     */
    @WebMethod(operationName = "operation")
    public String operation(@WebParam(name = "Nombre") String Nombre, @WebParam(name = "Apellido") String Apellido) {
        //TODO write your implementation code here:
        return Nombre + ' ' + Apellido;
    }
}
