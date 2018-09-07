/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Admin;
import model.User;


public class LogInServlet extends HttpServlet {


 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getContextPath()+ "/index.jsp" ;
        try {
            String username = request.getParameter("username1-submit");
            String password = request.getParameter("password1-submit");
            
            Admin admin = Admin.CheckAdmin(username,password);
            
            if(admin != null) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                url = request.getContextPath()+"/admin/adminIndex.jsp" ;
                
            }
            else {
                
                User user = User.CheckLogin(username, password);
                if(user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user); // bien session luu thong tin nguoi dung khi su dung
                    
                    
                }
                else {
                    
                    url = request.getContextPath()+"/login.jsp?result=login-false";
                }
            }
            
        }
        catch (Exception e) {
           url= request.getContextPath()+"/login.jsp" ;
           
        }
        
        response.sendRedirect(url);
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
