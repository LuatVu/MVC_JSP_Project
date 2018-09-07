/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import model.UserData;


public class CheckMailServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); 
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String url ="index.jsp" ;
        HttpSession session = request.getSession();
        User userTemp = (User) session.getAttribute("userTemp");
        String code = (String) session.getAttribute("code") ;
        String codeSubmit = request.getParameter("code-submit") ;
        if(code.equals(codeSubmit)) {
            try {
                User user = UserData.addUser(userTemp.getUsername(), userTemp.getPassword(), userTemp.getFullName(), userTemp.getEmail(), userTemp.getAddress(), userTemp.getPhone()) ;
                session.setAttribute("user", user);
                url = "index.jsp?result=signup-success" ;
            } catch (Exception e) {
                url = "checkEmail.jsp" ;
            }
        }
        else {
            url ="checkEmail.jsp?result=false-code" ;
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
