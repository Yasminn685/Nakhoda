package controller;

import dao.RosterDAO;
import model.Roster;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/rosterAdd")
public class RosterAddServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String rosterID = request.getParameter("rosterID");
        String userID = request.getParameter("userID");
        String taskID = request.getParameter("taskID");
        String shiftName = request.getParameter("shiftName");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String shiftDate = request.getParameter("shiftDate");
        String status = request.getParameter("status");

        RosterDAO dao = new RosterDAO();

        // =========================
        // 1. EMPTY VALIDATION
        // =========================
        if (rosterID == null || rosterID.trim().isEmpty()
                || userID == null || userID.trim().isEmpty()
                || taskID == null || taskID.trim().isEmpty()
                || shiftName == null || shiftName.trim().isEmpty()
                || startTime == null || startTime.trim().isEmpty()
                || endTime == null || endTime.trim().isEmpty()
                || shiftDate == null || shiftDate.trim().isEmpty()
                || status == null || status.trim().isEmpty()) {

            response.sendRedirect("rosterForm.jsp?err=empty");
            return;
        }

        // =========================
        // 2. DATE VALIDATION
        // =========================
        LocalDate selectedDate;

        try {
            selectedDate = LocalDate.parse(shiftDate);
        } catch (Exception e) {
            response.sendRedirect("rosterForm.jsp?err=invalidDate");
            return;
        }

        if (selectedDate.isBefore(LocalDate.now())) {
            response.sendRedirect("rosterForm.jsp?err=pastDate");
            return;
        }

        // =========================
        // 3. FOREIGN KEY CHECK
        // =========================
        if (!dao.isUserExists(userID)) {
            response.sendRedirect("rosterForm.jsp?err=userNotFound");
            return;
        }

        if (!dao.isTaskExists(taskID)) {
            response.sendRedirect("rosterForm.jsp?err=taskNotFound");
            return;
        }

        // =========================
        // 4. CONFLICT CHECK
        // =========================
        if (dao.isOperatorAssigned(userID, shiftDate)) {
            response.sendRedirect("rosterForm.jsp?err=operatorAssigned");
            return;
        }

        if (dao.isTaskAssigned(taskID, shiftDate)) {
            response.sendRedirect("rosterForm.jsp?err=taskAssigned");
            return;
        }

        // =========================
        // 5. CREATE OBJECT
        // =========================
        Roster r = new Roster(
                rosterID,
                userID,
                taskID,
                shiftName,
                startTime,
                endTime,
                shiftDate,
                status
        );

        // =========================
        // 6. INSERT
        // =========================
        boolean success = dao.addRoster(r);

        if (success) {
            response.sendRedirect("rosterList");
        } else {
            response.sendRedirect("rosterForm.jsp?err=dbFail");
        }
    }
}