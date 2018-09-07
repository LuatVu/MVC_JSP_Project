/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Item;
import model.ProductData;
import model.Products;


public class CartServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String command = request.getParameter("command");
        String productID = request.getParameter("productID");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        try {
            
            Products product = ProductData.getProductByID(productID);
            switch (command) {
                case "plus":
                    if (cart.getCartItems().containsKey(productID)) {
                        cart.addToCart(productID, new Item(product, cart.getCartItems().get(productID).getQuantity()));
                    } else {
                        cart.addToCart(productID, new Item(product, 1));
                    }
                    
                    break;
                case "remove":
                    cart.removeToCart(productID);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
        session.setAttribute("cart", cart);
        
        response.sendRedirect(request.getContextPath()+"/index.jsp");
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
