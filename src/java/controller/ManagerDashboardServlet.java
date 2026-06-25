package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/managerDashboard")
public class ManagerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();

        request.setAttribute("operatorList", dao.getAllOperators());
        request.setAttribute("totalOps", dao.countOperators(""));
        request.setAttribute("activeOps", dao.countOperators("AND status='active'"));
        request.setAttribute("inactiveOps", dao.countOperators("AND status='inactive'"));

        request.getRequestDispatcher("managerDashboard.jsp")
               .forward(request, response);
    }
}