/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.SupplierData;


public class SupplierServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); 
    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");
        String url ="admin/managerSupplier.jsp" ;
        
        String command = request.getParameter("command");

        
        try {
            switch(command) {
                case "update" :
                    int sId = Integer.parseInt(request.getParameter("sId")) ;
                    String newName = request.getParameter("newName");
                    String newAddress = request.getParameter("newAddress");
                    SupplierData.updateSupplier(sId, newName, newAddress) ;
                    break;
                    
                case "delete" :
                    int curentId = Integer.parseInt(request.getParameter("curentId")) ;
                    String error = SupplierData.deleteSupplier(curentId);
                    
                    if(error !=null) {
                        url ="admin/managerSupplier.jsp?error="+error ;
                    }
                    break;
                    
                case "add" :
                    String sName = request.getParameter("sName");
                    String sAddress = request.getParameter("sAddress");
                    SupplierData.addSupplier(sName, sAddress) ;
            }
            response.sendRedirect(url);
            
        } catch (Exception e) {
            String error = e.getMessage() ;
            url = "admin/managerSupplier.jsp?error="+error ;
            response.sendRedirect(url);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
