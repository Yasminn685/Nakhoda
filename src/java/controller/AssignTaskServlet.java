package controller;

import dao.RosterDAO;
import model.Roster;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/assignTask")
public class AssignTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            String userID = request.getParameter("userID");
            String taskID = request.getParameter("taskID");
            String shiftName = request.getParameter("shiftName");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String startDateStr = request.getParameter("startDate");

            LocalDate startDate = LocalDate.parse(startDateStr);

            RosterDAO dao = new RosterDAO();

            // AUTO GENERATE 7 DAYS
            for (int i = 0; i < 7; i++) {

                LocalDate date = startDate.plusDays(i);

                Roster r = new Roster();
                r.setRosterID("R" + System.currentTimeMillis() + i);
                r.setUserID(userID);
                r.setTaskID(taskID);
                r.setShiftName(shiftName);
                r.setStartTime(startTime);
                r.setEndTime(endTime);
                r.setShiftDate(date.toString());
                r.setStatus("Assigned");

                dao.addRoster(r);
            }

            response.sendRedirect("supervisorDashboard.jsp?success=assigned");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("supervisorDashboard.jsp?err=assignFail");
        }
    }
}