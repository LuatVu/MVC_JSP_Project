
<%@page import="model.Cart"%>
<%@page import="model.Admin"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sale Web</title>
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/View/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/css/style.css"/>

        <script type ="text/javascript" src="${pageContext.request.contextPath}/View/js/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/View/bootstrap/js/bootstrap.min.js"> </script>

        <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet"> 

    </head>

    
    <%
        User user = null;
        
        if (session.getAttribute("user") != null) {
            user = (User) session.getAttribute("user");
        }
        
        String result = "";
        String scriptResult ="";
        
        if(request.getParameter("result")!= null) {
            result = request.getParameter("result");
        }
        
        if(result.equals("payment-success")) {
            scriptResult = "alert('Thanh toán thành công! Đăng nhập email để xem lại đơn hàng!')";
        }
        else if(result.equals("sendmail-false")) {
            scriptResult = "alert('Chúng tôi đã gặp sự cố trong quá trình gửi mail cho bạn!')";
        }
        else if(result.equals("signup-success")) {
            scriptResult ="alert('Đăng kí thành công!')";
        }
        else if(result.equals("acc-exist")) {
            scriptResult ="alert('Tài khoản này đã tồn tại!')";
        }
        else if(result.equals("input-false")) {
            scriptResult ="alert('Số điện thoại không đúng!')";
        }
        
        
        
        
    %>
    <script>
        
        <%=scriptResult %> ;
        
    </script>
    

    <body>

        <%if (user != null) {%>
            <jsp:include page="/user/userheader.jsp"></jsp:include>
        <% } else { %>
            <jsp:include page="header.jsp"></jsp:include>
        <% } %>
        
        <jsp:include page="content.jsp"></jsp:include>
        <jsp:include page="footer.jsp"></jsp:include>
        
    </body>
</html>
