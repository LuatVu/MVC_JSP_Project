
<%@page import="model.Admin"%>
<%@page import="model.CategoryData"%>
<%@page import="model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ProductData"%>
<%@page import="model.Products"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý sản phẩm</title>
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/View/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/css/style.css"/>

        <script type ="text/javascript" src="${pageContext.request.contextPath}/View/js/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/View/bootstrap/js/bootstrap.min.js"> </script>

        <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet"> 

    </head>
    
    <%
        Admin admin = (Admin) session.getAttribute("admin") ;
        if(admin == null) {
            response.sendRedirect("../index.jsp");
        }
        
        String category ="";
        ArrayList<Products> listProduct = new ArrayList();
        if(request.getParameter("order") != null) {
            listProduct = ProductData.getMostProduct();
        }
        else if(request.getParameter("category")==null) {
            listProduct = ProductData.getProductList() ;
        }
        else {
            String categoryId = request.getParameter("category") ;
            listProduct = ProductData.getProductListByCategory(categoryId) ;
            category = CategoryData.getCategoryNameById(categoryId) ;
        }
        
        String scriptResult ="";
        if(request.getParameter("error") !=null) {
            String error = "Có lỗi: " + request.getParameter("error");
            scriptResult = "alert('"+error+"')";
       }
    %>
    <body>
        <script>
            $(document).ready(function(){
               <%=scriptResult %> ;
            }) ;
            
        </script>
        <jsp:include page="adminHeader.jsp"></jsp:include>
        <div class="container">
            <!-- Content -->
            <div class = "content">

              <div class="row">
                <div class="col-md-2 well">
                  <jsp:include page="navleft.jsp"></jsp:include>
                </div> <!-- End md-2 -->
                
                <!-- Product review-->
                <div class="col-md-10 well">
                    <h1> Quản lý Sản Phẩm </h1>
                    <hr>
                    <div class="row" id="category">
                      <div class="dropdown col-md-3">
                        <button class="dropdown-toggle btn btn-group btn-info" data-toggle="dropdown" href="#">Sắp xếp theo danh mục</button>
                        <ul class="dropdown-menu">
                            <li><a href="managerProduct.jsp">Toàn bộ sản phẩm</a></li>
                            <li><a href="managerProduct.jsp?order=hot">Sản phẩm đang hot</a></li>
                            <%
                                for(Category c : CategoryData.getCategoryList()) {
                            %>
                            <li><a href="managerProduct.jsp?category=<%=c.getCategoryID() %>"> <%= c.getCategoryName() %> </a></li>
                            <%
                                }
                             %>
                        </ul>
                      </div>
                      <div class="col-md-3">
                            <h4> <b> <%=category %> </b></h4>
                      </div>
                      <div class="col-md-3"> </div>
                      <div class="col-md-3" id="btn-addProduct">
                            <a href="addProduct.jsp" class="btn btn-lg btn-success">Thêm sản phẩm mới</a>
                       </div>
                    </div>

                  <h3> Danh sách sản phẩm: </h3>
                  <div class="row">
                        <table class="table table-bordered" id="table-user">
                          <thead>
                            <tr>
                              <th>ID Sản Phẩm </th>
                              <th>Tên Sản phẩm</th>
                              <th>Danh mục</th>
                              <th align="right">Giá gốc (đ)</th>
                              <th align="right">Giá bán (đ)</th>
                              <th>Hãng sản xuất</th>
                              <th>Xuất xứ</th>
                              <th>Hành động</th>
                            </tr>
                          </thead>
                            <tbody>
                            <%
                               for(Products product: listProduct) {  
                            %>
                            <tr>
                                <td> <%= product.getPID() %> </td>
                                <td> <%= product.getPName() %> </td>
                                <td> <%= product.getCategoryName()%> </td>
                                <td align="right"> <%= product.getInputPrice()%></td>
                                <td align="right"> <%= product.getPPirce() %></td>
                                <td> <%= product.getSupplyName() %> </td>
                                <td> <%= product.getSupplyAddress() %> </td>
                                <td> 
                                    <a href="editProduct.jsp?productId=<%=product.getPID() %>" class="btn btn-success">Sửa</a> 
                                    <a href="#delete-<%=product.getPID() %>" data-toggle="modal" class="btn btn-danger">Xóa</a>
                                </td>

                            </tr>

                            <% } %>
                            </tbody>
                        </table>
                    </div> <!-- End row -->
                </div> <!-- End Prd review -->
            </div> <!-- End conntent -->
            
        </div> <!-- End container -->
        <%
        for(Products product : listProduct) {  
        %>
       <!-- modal-delete-->
        <div class="modal fade" id="delete-<%=product.getPID() %>">
            <form action="../ProductServlet" method="POST" role="form">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">Việc xóa sản phẩm sẽ ảnh hưởng tới hóa đơn liên quan đến sản phẩm này. Chắc chắn muốn xóa "<%=product.getPName() %>" chứ?</h4>
                   
                  </div>
                  <div class="modal-footer">
                   
                    <button type="button" class="btn btn-default" data-dismiss="modal">Không chắc lắm</button>
                    <input type="hidden" name="command" value="delete">
                    <input type="hidden" name="pId" value="<%=product.getPID() %>" >
                    <input type="submit" class="btn btn-primary" value="Ừ. Tao chắc" name="Delete">
                  </div>
                </div>
              </div>
            </form>
        </div> <!-- End modal -->
       <% } %>
      
       <jsp:include page="../footer.jsp"></jsp:include>
        
    </body>
</html>
