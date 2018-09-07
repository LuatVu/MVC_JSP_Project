/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Bill;
import model.BillDetail;
import model.Cart;
import model.Item;
import model.User;
import otherAddOn.Mail;


public class PaymentServlet extends HttpServlet {





    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String recieverName = request.getParameter("receiver-name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String payOption = request.getParameter("pay-option");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        
        int totalMoney = cart.totalMoney() ;
        int userId = user.getUserID();
        Timestamp time = new Timestamp(new Date().getTime() ) ;
        
        try {
            
            Bill bill = new Bill(userId, totalMoney, recieverName, address, payOption, time);
            
            for(Map.Entry<String, Item> listItem : cart.getCartItems().entrySet()) {
                int billId = bill.getBillId();
                String productId = listItem.getValue().getProduct().getPID() ; 
                int Pprice = listItem.getValue().getProduct().getPPirce() ;
                int quantity = listItem.getValue().getQuantity() ;
                
                BillDetail billDetail = new BillDetail(billId, productId, Pprice, quantity);
                    
            }
            // Gửi mail cho người dùng
            String error = Mail.sendMail(user.getEmail(),"Hóa đơn tại LPWEBSITE", "Xin chào "+ user.getFullName() +"\nBạn đã gửi yêu cầu thanh toán 1 đơn hàng tại lpwebsite. Chi tiết:" + "\nMã hóa đơn: "+bill.getBillId() + "\nTổng số tiền: "+ totalMoney + " Đồng" + "\n\nCảm ơn bạn đã mua hàng tại lpwebsite!") ;
            
            if(error !=null) {
               response.sendRedirect("index.jsp?result=sendmail-false");
            }
            else {
                response.sendRedirect("index.jsp?result=payment-success");
            }
            cart = new Cart();
            session.setAttribute("cart", cart) ;
        }
        catch (Exception e) {
            response.sendRedirect("index.jsp?result=payment-false");
            
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
