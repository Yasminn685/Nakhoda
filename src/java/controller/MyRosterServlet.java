package controller;

import dao.RosterDAO;
import model.Roster;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/myRoster")
public class MyRosterServlet extends HttpServlet {

    private RosterDAO rosterDAO;

    @Override
    public void init() throws ServletException {
        rosterDAO = new RosterDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userID = (String) session.getAttribute("userID");
        String role = (String) session.getAttribute("role");
        String name = (String) session.getAttribute("name");

        // SECURITY CHECK
        if (userID == null || role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (!"operator".equalsIgnoreCase(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // LOAD DATA
        List<Roster> rosterList = rosterDAO.getRosterByUser(userID);

        // SET ATTRIBUTES
        request.setAttribute("rosterList", rosterList);
        request.setAttribute("operatorName", name);
        request.setAttribute("role", role);

        // FORWARD TO JSP
        request.getRequestDispatcher("/myRoster.jsp")
                .forward(request, response);
    }
}