/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import otherAddOn.Mail;


public class SignUpServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = "index.jsp";
        try{
            
            String username = request.getParameter("username-submit");
            String password = request.getParameter("password-submit");
            String repassword = request.getParameter("repassword-submit");
            String name = request.getParameter("name-submit");
            String email = request.getParameter("email-submit");
            String address = request.getParameter("address-submit");
            String phoneTemp = request.getParameter("phone-submit");
            int phone = Integer.parseInt(phoneTemp);
            if(User.checkUsername(username)) {
                
                url = "index.jsp?result=acc-exist";
            }
            else {
                User userTemp = new User(username, password, name, email, address, phone);
                HttpSession session = request.getSession();
                session.setAttribute("userTemp", userTemp);
                url = "checkEmail.jsp" ;
//                url = "/index.jsp?result=signup-success";
                
                int codeTemp = (int) Math.floor(Math.random()*8999 + 1000) ;
                String code = Integer.toString(codeTemp);
                session.setAttribute("code", code);
                
                // gui mail 
                String error = Mail.sendMail(email,"Xác nhận Email tại LPWEBSITE", "Xin chào "+ userTemp.getFullName() +"\nMã xác nhận của bạn là: " + code) ;
            
                if(error !=null) {
                   url = "index.jsp?result=sendmail-false" ;
                }
                
            }
            
        }
        catch(Exception e) {
          url = "index.jsp?result=false";
            
        }
        response.sendRedirect(url);
        
        
    }



}
