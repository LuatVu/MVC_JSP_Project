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
import model.BillData;


public class BillServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        String url ="admin/managerBill.jsp" ;
        
        String command = request.getParameter("command");

        
        try {
            switch(command) {
//                case "update" :
//                    String oldId = request.getParameter("oldId");
//                    String newId = request.getParameter("newId");
//                    String newName = request.getParameter("newName");
//                    CategoryData.updateCategory(oldId, newId, newName) ;
//                    break;
                    
                case "cancel" :
                    String billId = request.getParameter("billId");
                    
                    String error = BillData.deleteBill(billId) ;
                    if(error !=null) {
                        url ="admin/managerBill.jsp?error="+error ;
                    }
                    break;
                    
            }
            response.sendRedirect(url);
            
        } catch (Exception e) {
            String error = e.getMessage().toString() ;
            url = "admin/managerBill.jsp?error="+error ;
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
