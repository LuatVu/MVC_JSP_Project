
<%@page import="model.Cart"%>
<%@page import="model.CategoryData"%>
<%@page import="model.User"%>
<%@page import="model.ProductData"%>
<%@page import="model.Products"%>
<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%
        User user = null;
        if (session.getAttribute("user") != null) {
            user = (User) session.getAttribute("user");
        }
            String productID = "";
            productID = request.getParameter("productId").toString();
            Products product = new Products();
            product = ProductData.getProductByID(productID);
            
        Cart cart = (Cart) session.getAttribute("cart") ;
        if(cart == null) {
            cart = new Cart() ;
            session.setAttribute("cart", cart);
        }
    %>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> <%=product.getPName() %></title>
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/View/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/css/style.css"/>

        <script type ="text/javascript" src="${pageContext.request.contextPath}/View/js/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/View/bootstrap/js/bootstrap.min.js"> </script>

        <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet"> 
        
        
        
    </head>
    <meta property="fb:app_id" content="1185086244911379" />
    <body>
     <script>
        window.fbAsyncInit = function() {
        FB.init({
          appId      : '1185086244911379',
          xfbml      : true,
          version    : 'v2.8'
        });
      };

        (function(d, s, id){
           var js, fjs = d.getElementsByTagName(s)[0];
           if (d.getElementById(id)) {return;}
           js = d.createElement(s); js.id = id;
           js.src = "//connect.facebook.net/en_US/sdk.js";
           fjs.parentNode.insertBefore(js, fjs);
         }(document, 'script', 'facebook-jssdk'));
    </script>
        
        <%if (user != null) {%>
            <jsp:include page="user/userheader.jsp"></jsp:include>
        <% } else { %>
            <jsp:include page="header.jsp"></jsp:include>
        <% } %>
        <div class="container">
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
                <h1> Thông tin chi tiết sản phẩm </h1>
            </div>
            
            <hr>
            <div class="Product">

              <div class="row">
                <div class="col-md-2" >
                    
                  <div class="nav nav-pills nav-stacked">
                    <%
                        for(Category c : CategoryData.getCategoryList()) {
                    %>
                    
                    <li><a href="index.jsp?category=<%=c.getCategoryID() %>"><%= c.getCategoryName() %> </a></li>
                        
                    <%
                        }
                    %>
                  </div>
                  
                </div> <!-- End md-2 -->
                
                <!--  thông tin chi tiết-->
                <div id="productDetail" class="col-md-8">
                    
                    <div class="row">
                        <div class="col-md-8">
                            <h2> <b> <%=product.getPName()%> </b> </h2>
                        </div>
                        <div class="col-md-4">
                            <a href="CartServlet?command=plus&productID=<%=product.getPID()%>" id="<%=product.getPID() %>" data-name="<%=product.getPName() %>" data-price="<%=product.getPPirce() %>" class="add-to-cart btn btn-danger btn-addLarge"><h4><b>Thêm vào giỏ hàng</b></h4></a> 
                        </div>
                    </div>
                        
                    <hr>
                    <!-- hiển thị hình ảnh-->
                    <div class="row well">
                        <div class="col-md-6 img">
                            <img src="${pageContext.request.contextPath}/View/images/<%=product.getImg()%>" alt="<%=product.getPID() %>" class="img-detail table-bordered img-responsive"> 
                        </div>

                        <div class="col-md-6">
                            <h3>
                                <B>THÔNG TIN CƠ BẢN:</B>
                                <br> <br>
                                <ul>
                                    <li>Tên sản phẩm: <%=product.getPName() %></li>
                                    <li>Loại mặt hàng: <%=product.getCategoryName() %></li>
                                    <li>Giá bán: <%=product.getPPirce() %> đ</li>
                                    <li>Hãng sản xuất: <%=product.getSupplyName() %></li>
                                    <li> Xuất xứ: <%=product.getSupplyAddress() %> </li>
                                </ul>
                            </h3>
                        </div>
                    </div>
                    <hr>
                    <div class="descriptionDetail row well">
                        <h2> <b> Thông số kỹ thuật: </b> </h2>
                        <h3>
                            <%=product.getPDescription() %>
                        </h3>
                    </div>
                    <hr>
                    
                    
                </div> <!-- End md-8 -->
                
                <!-- Cart Left -->
                <div class="col-md-2 well">
                  <div>
                    <button type="button" class="glyphicon glyphicon-shopping-cart"></button>
                    <b>Giỏ Hàng</b>
                    <br> <br> 
                    <b> Tổng giá:</b> <span id="total-price"> </span><%=cart.totalMoney() %>  <span> đ</span>
                    <br> <br>
                  </div>
                  <a href="#cart-detail"> <button type="button" class="btn btn-info">Chi tiết giỏ hàng</button> </a>
                </div> <!-- End Cart Left -->
              </div> <!-- End row -->
            </div> <!-- End Product -->
            <div class="row">
                <div class="col-md-2"></div>
                <div class="fb-comments col-md-8" data-href="http://localhost:8080/WebProjectI/productDetail.jsp?productId=<%=product.getPID() %>" data-width="750" data-numposts="5"></div>
            </div>
            
        </div> <!-- End container -->
        
        
        
        
    </body>
</html>
