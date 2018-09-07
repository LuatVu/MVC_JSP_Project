

<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>

        <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="row">
            <div class="col-md-8">
                <div class="navbar-header">
                  <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/adminIndex.jsp">LP WebSite</a>
                </div>
                <!-- Main nav -->
                <ul class="nav navbar-nav">
                
                 
                  <li> <a href="managerUser.jsp"> Quản lý Người dùng</a> </li> 
                  <li> <a href="managerCategory.jsp"> Quản lý Danh Mục</a> </li> 
                  <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> Quản Lý Sản Phẩm<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="managerProduct.jsp">Danh sách sản phẩm</a></li>
                      <li><a href="addProduct.jsp">Thêm sản phẩm</a></li>
                    </ul>
                  </li>

                   
                   
                  <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> Quản Lý Xuất nhập<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="managerSupplier.jsp">Nhà cung cấp</a></li>
                      <li><a href="managerBill.jsp">Hóa đơn</a></li>
                    </ul>
                  </li>
                </ul>
              </div> <!-- Col-md-8 -->

              <!-- Nav right -->
              <div class="col-md-4">
                <ul class="nav navbar-nav navbar-right">
                  <li><a href="#">ADMIN: ${admin.name }</a></li>
                  <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Tài khoản<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li class="active"><a href="#">${admin.username}</a></li>
                      <li><a href="#">Thông tin tài khoản</a></li>
                      <li><a href="${pageContext.request.contextPath}/LogOutServlet">Đăng xuất</a></li>
                    </ul>
                  </li>
                  
                </ul>
              </div>
            </div> <!-- End row -->
          </nav> <!-- End nav -->
    </body>
</html>
