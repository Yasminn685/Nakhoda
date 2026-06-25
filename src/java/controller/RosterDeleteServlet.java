package controller;

import dao.RosterDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/rosterDelete")
public class RosterDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("Operator".equals(role)) {
            response.sendRedirect("rosterList?err=forbidden");
            return;
        }

        String rosterID = request.getParameter("rosterID");

        RosterDAO dao = new RosterDAO();
        boolean ok = dao.deleteRoster(rosterID);

        if (ok) {
            response.sendRedirect("rosterList?msg=deleted");
        } else {
            response.sendRedirect("rosterList?err=deletefail");
        }
    }
}