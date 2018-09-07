
<%@page import="model.Cart"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán hóa đơn</title>
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/View/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/css/style.css"/>

        <script type ="text/javascript" src="${pageContext.request.contextPath}/View/js/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/View/bootstrap/js/bootstrap.min.js"> </script>

        <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">

    </head>
    ${result}
    <%
        User user = (User) session.getAttribute("user") ;
        if(user == null) {
            response.sendRedirect("login.jsp");
        }
        Cart cart = (Cart) session.getAttribute("cart") ;



    %>

    <body>

        <jsp:include page="/user/userheader.jsp"></jsp:include>

        <form action="PaymentServlet" method="POST" role="form">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">Thanh toán đơn hàng</h4>
              </div>
              <div class="modal-body">

                <div class="form-group">
                  <label for="">Tên người nhận *</label>
                  <input type="text" class="form-control" id="" placeholder="Người nhận" required="required" name="receiver-name">
                </div>
                <div class="form-group">
                  <label for="">Địa chỉ *</label>
                  <input type="text" class="form-control" id="" placeholder="Địa chỉ" required="required" name="address">
                </div>
                <div class="form-group">
                  <label for="">Số điện thoại người nhận: *</label>
                  <input type="text" class="form-control" id="" placeholder="Số điện thoại" required="required" name="phone">
                </div>
                <div class="form-group">
                  <label for="">Số tiền cần thanh toán: </label>
                  <span> <%=cart.totalMoney() %> đ </span>
                </div>
                  
                <div>
                    <label>Hình thức thanh toán</label>
                    <select name="pay-option">
                        <option value="Chuyển khoản">Chuyển khoản</option>
                        <option value="Tiền mặt">Tiền mặt</option>
                    </select>
                </div>

              </div>

              <div class="modal-footer">

                
                <input type="submit" class="btn btn-primary" value="Thanh toán" name="payment">
              </div>
            </div>
          </div>
        </form>



    </body>
</html>
