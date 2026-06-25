package controller;

import dao.UserDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        // ✅ VALIDATION LETAK SINI
        String regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";

        if (newPassword == null || !newPassword.matches(regex)) {
            response.sendRedirect("forgotPassword.jsp?error=password");
            return;
        }

        UserDAO dao = new UserDAO();
        boolean success = dao.resetPassword(email, newPassword);

        if (success) {
            response.sendRedirect("forgotPassword.jsp?success=1");
        } else {
            response.sendRedirect("forgotPassword.jsp?error=1");
        }
    }
}