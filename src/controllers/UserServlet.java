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
import model.UserData;


public class UserServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        String url ="admin/managerUser.jsp" ;
        
        String command = request.getParameter("command");

        
        try {
            switch(command) {
                case "update" :
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    String address = request.getParameter("newAddress");
                    int phone = Integer.parseInt(request.getParameter("newPhone")) ;
                    String name = request.getParameter("newName");
                    String pass = request.getParameter("newpassword");
                    UserData.updateUser(userId, address, phone, name, pass ) ;
                    break;
                    
                case "delete" :
                    String curentId = request.getParameter("curentId");
                    
                    String error = UserData.deleteUser(curentId) ;
                    if(error !=null) {
                        url ="admin/managerUser.jsp?error="+error ;
                    }
                    break;
                    
            }
            response.sendRedirect(url);
            
        } catch (Exception e) {
            String error = e.getMessage().toString() ;
            url = "admin/managerUser.jsp?error="+error ;
            response.sendRedirect(url);
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
