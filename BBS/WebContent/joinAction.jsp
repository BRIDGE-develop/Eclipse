<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="users.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="users" class="users.Users" scope="page" />
<jsp:setProperty name="users" property="userID" />
<jsp:setProperty name="users" property="userPassword" />
<jsp:setProperty name="users" property="userName" />
<jsp:setProperty name="users" property="userGender" />
<jsp:setProperty name="users" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") !=null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
		if (users.getUserID() == null || users.getUserPassword() == null || users.getUserName() == null
				|| users.getUserGender() == null || users.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(users); 
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디 입니다.')'");
				script.println("</script>");
			}
			else {
				session.setAttribute("userID",users.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>