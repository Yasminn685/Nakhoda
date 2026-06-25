package controller;

import dao.RosterDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/rosterApprove")
public class RosterApproveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String role = (String) session.getAttribute("role");

        // SECURITY CHECK
        if (role == null || !role.equalsIgnoreCase("manager")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String rosterID = request.getParameter("rosterID");
        String status = request.getParameter("status");

        // allow only approved/rejected
        if (status == null ||
            !(status.equalsIgnoreCase("Approved")
            || status.equalsIgnoreCase("Rejected"))) {

            response.sendRedirect("rosterPending.jsp?err=invalid");
            return;
        }

        RosterDAO dao = new RosterDAO();

        boolean ok = dao.updateRosterStatus(rosterID, status);

        if (ok) {
            response.sendRedirect("rosterPending.jsp?msg=updated");
        } else {
            response.sendRedirect("rosterPending.jsp?err=1");
        }
    }
}