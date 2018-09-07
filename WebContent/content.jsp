

<%@page import="model.CategoryData"%>
<%@page import="java.util.Map"%>
<%@page import="model.Item"%>
<%@page import="model.Cart"%>
<%@page import="java.util.Collections"%>
<%@page import="model.Products"%>
<%@page import="model.ProductData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Content</title>
    </head>
    <body>
   <%

      
      ArrayList<Products> productList = new ArrayList<Products>();
      String categoryId = "";
      if(request.getParameter("category") != null) {
          categoryId = request.getParameter("category");
          productList = ProductData.getProductListByCategory(categoryId);
      }
      else {
         
          ArrayList<Products> pListTemp = ProductData.getMostProduct();
          for(int i= 0; i<6; i++) {
              productList.add(pListTemp.get(i));
        }
      }
      
      Cart cart = (Cart) session.getAttribute("cart") ;
        if(cart == null) {
            cart = new Cart() ;
            session.setAttribute("cart", cart);
        }
   %>
   
   <script>
       $(document).ready(function(){
           $(".categoryLeft").removeClass("active");
           $("#<%=categoryId %>").addClass("active");
       });
   </script>  
        <!-- Content -->
      <div class = "content container">
        <!-- Banner -->
        <div id="carousel-id" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
           <li data-target="#carousel-id" data-slide-to="0" class="active"></li>
           <li data-target="#carousel-id" data-slide-to="1"></li>
           <li data-target="#carousel-id" data-slide-to="2"></li>
          </ol>

          <div class="carousel-inner">
            <div class="item active">
              <img src="${pageContext.request.contextPath}/View/images/ipad-banner.jpg" width="30%" class="center-block">
            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/View/images/iphone7-banner.jpg" width="30%" class="center-block">
            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/View/images/laptop-banner.jpg" width="30%" class="center-block">
            </div>
          </div>
          <a class="left carousel-control" href="#carousel-id" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
          <a class="right carousel-control" href="#carousel-id" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
        </div> <!-- End banner -->
        
        <div class="text-center">
           <h1> Welcome To My Website </h1>
        </div>

        <div class="Product">

          <div class="row">
            <div class="col-md-2">
              <div class="nav nav-pills nav-stacked">
                <%
                    for(Category c : CategoryData.getCategoryList()) {
                %>
                
                <li class="categoryLeft" id="<%=c.getCategoryID()%>" ><a href="index.jsp?category=<%=c.getCategoryID() %>"> <%= c.getCategoryName() %> </a></li>
                
                <%
                    }
                %>
              </div>
            </div> <!-- End md-2 -->

            <!-- Product review-->
            <div class="col-md-8 well">
                <hr>
                <% 
                  if(request.getParameter("category") == null) {
                %>
                <h2> <b>Các sản phẩm đang hot </b></h2>
                <% } %>
              <div class="row preview-product">
                  <br>
                <%
                    for(Products pro : productList) { 
                %>
                <div class="col-md-6">
                  <div class="table-bordered">
                    <img src="${pageContext.request.contextPath}/View/images/<%=pro.getImg()%>" alt="<%=pro.getPID() %>" class="img-display table-bordered img-responsive"> 
                    <div class="caption">
                      <h3> <%= pro.getPName() %> </h3>
                      <p> Giá bán: <%= pro.getPPirce() %> đ </p>
                      <p>
                          <a href="CartServlet?command=plus&productID=<%=pro.getPID()%>" id="<%=pro.getPID() %>" data-name="<%=pro.getPName() %>" data-price="<%=pro.getPPirce() %>" class="add-to-cart btn btn-primary">Thêm vào giỏ hàng</a> 
                        <a href="productDetail.jsp?productId=<%=pro.getPID() %>" class="btn btn-default" role="button">Chi tiết</a>
                      </p>
                    </div>
                  </div>
                </div> <!-- End md-6 -->
                <%
                    }
                %>

              </div> <!-- End row -->
            </div> <!-- End Prd review -->
          
            <!-- Cart Left -->
            <div class="col-md-2 well">
              <div>
                <button type="button" class="glyphicon glyphicon-shopping-cart"></button>
                <b>Giỏ Hàng</b>
                <br> <br> 
                <b> Tổng giá:</b> <span id="total-price1"> </span> <%=cart.totalMoney() %>  <span> đ</span>
                <br> <br>
              </div>
              <a href="#cart-detail"> <button type="button" class="btn btn-info">Chi tiết giỏ hàng</button> </a>
            </div> <!-- End Cart Left -->
          </div> <!-- End Product row -->
        </div>  <!-- End class Product -->

        <!-- Cart Detail -->
        <div id="cart-detail">
          <span> Chi tiết giỏ hàng </span>
          <div class="row">
            <table class="table table-bordered" id="table-products">
              <thead>
                <tr>
                  <th>Mã Sản Phẩm</th>
                  <th>Tên sản phẩm</th>
                  <th>Giá</th>
                  <th>Số lượng</th>
                  <th>Tổng giá</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
              <hr>
               <% for(Map.Entry<String, Item> list : cart.getCartItems().entrySet() ) { %>
                <tr>
                    <td> <%=list.getValue().getProduct().getPID() %> </td>
                    <td> <%=list.getValue().getProduct().getPName() %> </td>
                    <td style="text-align: right"> <%=list.getValue().getProduct().getPPirce() %> </td>
                    <td style="text-align: right"> <%=list.getValue().getQuantity() %> </td>
                    <td style="text-align: right"> <%=list.getValue().getProduct().getPPirce() *list.getValue().getQuantity() %> </td>
                    <td> <a href="CartServlet?command=remove&productID=<%=list.getValue().getProduct().getPID()%>" class="btn btn-danger">Remove</a> </td>
                </tr>
               <% } %>

              </tbody>
            </table>

               <div class="row">
                   <div class="col-md-3">
                        <h3>Tổng: <%=cart.totalMoney() %> đồng </h3>
                   </div>
                   <div class="col-md-3">
                       <h3> <a href="payment.jsp" class="btn btn-success" id="button-buy">Thanh Toán</a> </h3>
                   </div>
               </div>

        </div> <!-- End Cart Detail -->
      </div> <!-- End Content -->

    </body>
</html>
