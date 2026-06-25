package controller;

import dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userID = (String) session.getAttribute("userID");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // check confirm password
        if(!newPassword.equals(confirmPassword)){

            response.sendRedirect("profile.jsp?error=nomatch");
            return;
        }

        UserDAO dao = new UserDAO();

        boolean ok = dao.changePassword(
                userID,
                currentPassword,
                newPassword
        );

        if(ok){

            response.sendRedirect("profile.jsp?success=password");

        } else {

            response.sendRedirect("profile.jsp?error=wrongpass");

        }
    }
}