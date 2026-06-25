package controller;

import dao.RosterDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class GenerateRosterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String taskID = request.getParameter("taskID");
        String shiftName = request.getParameter("shiftName");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String startDate = request.getParameter("startDate");

        RosterDAO dao = new RosterDAO();

        dao.generateWeeklyRoster(
            taskID,
            shiftName,
            startTime,
            endTime,
            Date.valueOf(startDate)
        );

        response.sendRedirect("rosterList?success=1");
    }
}