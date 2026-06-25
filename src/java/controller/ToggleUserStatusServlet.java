package controller;

import dao.UserDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/toggleUserStatus")
public class ToggleUserStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userID = request.getParameter("userID");
        String status = request.getParameter("status");

        UserDAO dao = new UserDAO();
        dao.updateStatus(userID, status);

        response.sendRedirect("managerDashboard");
    }
}