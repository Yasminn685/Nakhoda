package controller;

import dao.UserDAO;
import model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Check email duplicate
        if (dao.emailExists(email)) {
            response.sendRedirect("managerDashboard?err=email");
            return;
        }

        User u = new User();

        u.setUserID(dao.generateNextUserID(role));
        u.setName(name);
        u.setEmail(email);
        u.setPhoneNo(phoneNo);
        u.setPassword(password);
        u.setRole(role);
        u.setStatus("active");

        boolean success = dao.register(u);

        if (success) {
            response.sendRedirect("managerDashboard?success=1");
        } else {
            response.sendRedirect("managerDashboard?err=1");
        }
    }
}