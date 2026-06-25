package controller;

import dao.UserDAO;
import model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== REGISTER SERVLET HIT ===");

        // =========================
        // GET FORM PARAMETERS
        // =========================
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Debug output
        System.out.println("name = " + name);
        System.out.println("email = " + email);
        System.out.println("phoneNo = " + phoneNo);
        System.out.println("role = " + role);

        // =========================
        // VALIDATION
        // =========================
        if (name == null || email == null || phoneNo == null ||
            password == null || role == null ||
            name.trim().isEmpty() ||
            email.trim().isEmpty() ||
            phoneNo.trim().isEmpty() ||
            password.trim().isEmpty() ||
            role.trim().isEmpty()) {

            response.sendRedirect("register.jsp?err=1");
            return;
        }

        UserDAO dao = new UserDAO();

        // =========================
        // CHECK DUPLICATE EMAIL
        // =========================
        if (dao.emailExists(email)) {
            System.out.println("Email already exists: " + email);
            response.sendRedirect("register.jsp?err=email");
            return;
        }

        // =========================
        // GENERATE USER ID
        // =========================
        String newUserID = dao.generateNextUserID(role);

        System.out.println("Generated User ID: " + newUserID);

        // =========================
        // CREATE USER OBJECT
        // =========================
        User u = new User();
        u.setUserID(newUserID);
        u.setName(name);
        u.setEmail(email);
        u.setPhoneNo(phoneNo);
        u.setPassword(password);
        u.setRole(role);

        // =========================
        // SAVE TO DATABASE
        // =========================
        boolean ok = dao.register(u);

        if (ok) {
            System.out.println("Registration successful.");
            response.sendRedirect("login.jsp?registered=1");
        } else {
            System.out.println("Registration failed.");
            response.sendRedirect("register.jsp?err=1");
        }
    }
}