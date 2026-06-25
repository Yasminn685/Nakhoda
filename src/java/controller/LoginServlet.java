/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (email == null || password == null || role == null
                || email.trim().isEmpty() || password.trim().isEmpty() || role.trim().isEmpty()) {
            response.sendRedirect("login.jsp?err=1");
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.login(email, password, role);   // ✅ only 3 params

        // Gunakan .equalsIgnoreCase() supaya lebih selamat daripada ralat huruf besar/kecil
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userID", user.getUserID());
            session.setAttribute("name", user.getName());
            session.setAttribute("role", user.getRole());

            // Tukar kepada equalsIgnoreCase
            if ("Manager".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("managerDashboard");
            } else if ("Supervisor".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("supervisorDashboard");
            } else {
                response.sendRedirect("operatorDashboard");
            }
        } else {
            response.sendRedirect("login.jsp?err=1");
        }
    }
}
