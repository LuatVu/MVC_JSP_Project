

<%@page import="model.CategoryData"%>
<%@page import="model.Category"%>
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
                  <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">LP WebSite</a>
                </div>
                <!-- Main nav -->
                <ul class="nav navbar-nav">
                
                  <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Sản Phẩm<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <%
                            for(Category c : CategoryData.getCategoryList()) {
                        %>
                        <li><a href="./index.jsp?category=<%=c.getCategoryID() %>"> <%= c.getCategoryName() %> </a></li>
                        <%
                            }
                         %>
                    </ul>
                  </li>
                  <li><a href="#">Giới Thiệu</a></li>
                  <li><a href="#">Liên Hệ</a></li>
                </ul>
              </div> <!-- Col-md-5 -->

<!--              <div class="col-md-4">
                <form class="navbar-form navbar-left" role="search">
                  <div class="form-group" >
                    <input type="text" class="form-control" placeholder="Search" id="search-text">
                  </div>
                  <button  type="button" class="btn btn-info">
                    <span class="glyphicon glyphicon-search"></span> Search
                  </button>
                </form>
              </div>  Md-4 -->

              <!-- Nav right -->
              <div class="col-md-4">
                <ul class="nav navbar-nav navbar-right">
                  <li><a href="#">Xin chào: ${user.fullName}</a></li>
                  <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Tài khoản<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li class="active"><a href="#">${user.username}</a></li>
                      <li><a href="${pageContext.request.contextPath}/user/userInfo.jsp">Thông tin tài khoản</a></li>
                      <li id="logout1" ><a href="${pageContext.request.contextPath}/LogOutServlet">Đăng xuất</a></li>
                    </ul>
                  </li>
                  
                </ul>
              </div>
            </div> <!-- End row -->
          </nav> <!-- End nav -->
    </body>
</html>
