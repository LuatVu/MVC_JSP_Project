/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ArrayListFileItem;
import model.ProductData;
import model.Products;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;



public class ProductServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url ="admin/managerProduct.jsp" ;
        
        String path = request.getRealPath("/View/images");
        DiskFileItemFactory d = new DiskFileItemFactory();
        ServletFileUpload uploader = new ServletFileUpload(d);
        
        String command = request.getParameter("command");

        
        try {
            switch(command) {
                case "edit" :
                    
                    ArrayListFileItem listField = new ArrayListFileItem((ArrayList<FileItem>) uploader.parseRequest(request));
                    String oldId = listField.getValue("oldId");
                    String productId = listField.getValue("productId") ;
                    String pName = new String(listField.getValue("productName").getBytes("iso-8859-1"), "UTF-8");
                    int inputPrice = Integer.parseInt(listField.getValue("inputPrice"))  ;
                    int pPrice = Integer.parseInt(listField.getValue("PPrice") )  ;
                    int sId = Integer.parseInt(listField.getValue("supplierId") )  ;
                    String cId = listField.getValue("categoryId") ;
                    String description = new String(listField.getValue("description").getBytes("iso-8859-1"), "UTF-8");
                    
                    
                    FileItem image = listField.getFile("Img");
                    String img = image.getName();
                    File file = new File(path+"/"+img);
                    if(!file.exists()){
                        image.write(file);
                    }

                   
                    Products pro = new Products(productId, pName, inputPrice, pPrice, img, sId, cId, description );
                    
                    String error = ProductData.updateProduct(oldId, pro) ;
                    if(error !=null) {
                        url ="admin/managerProduct.jsp?error="+error ;
                    }
                    break;
                    
                case "delete" :
                    String pId = request.getParameter("pId");
                    String error1 = ProductData.deleteProduct(pId) ;
                    
                    if(error1 !=null) {
                        url ="admin/managerProduct.jsp?error="+error1 ;
                    }
                    break;
                    
                case "add" :
                    ArrayListFileItem listField1 = new ArrayListFileItem((ArrayList<FileItem>) uploader.parseRequest(request));
                    String oldId1 = listField1.getValue("oldId");
                    String productId1 = listField1.getValue("productId") ;
                    String pName1 = new String(listField1.getValue("productName").getBytes("iso-8859-1"), "UTF-8");
                    int inputPrice1 = Integer.parseInt(listField1.getValue("inputPrice"))  ;
                    int pPrice1 = Integer.parseInt(listField1.getValue("PPrice") )  ;
                    int sId1 = Integer.parseInt(listField1.getValue("supplierId") )  ;
                    String cId1 = listField1.getValue("categoryId") ;
                    String description1 = new String(listField1.getValue("description").getBytes("iso-8859-1"), "UTF-8");
                    
                    
                    FileItem image1 = listField1.getFile("Img");
                    String img1 = image1.getName();
                    File file1 = new File(path+"/"+img1);
                    if(!file1.exists()){
                        image1.write(file1);
                    }
                    
                    Products pro1 = new Products(productId1, pName1, inputPrice1, pPrice1, img1, sId1, cId1, description1 );
                    String error2 = ProductData.addProduct(pro1) ;
                    if(error2 !=null) {
                        url ="admin/managerProduct.jsp?error="+error2 ;
                    }
                    
            }
            response.sendRedirect(url);
            
        } catch (Exception e) {
            String error = e.getMessage().toString() ;
            url = "admin/managerProduct.jsp?error="+error ;
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
