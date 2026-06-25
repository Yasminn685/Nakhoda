package controller;

import dao.ReportDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ReportDAO dao = new ReportDAO();

        request.setAttribute(
                "totalOperators",
                dao.countOperators()
        );

        request.setAttribute(
                "activeOperators",
                dao.countActiveOperators()
        );

        request.setAttribute(
                "totalTasks",
                dao.countTasks()
        );

        request.setAttribute(
                "completedTasks",
                dao.countCompletedTasks()
        );

        request.setAttribute(
                "totalRosters",
                dao.countRosters()
        );

        request.setAttribute(
                "taskStatusMap",
                dao.getTaskStatusReport()
        );

        request.setAttribute(
                "workloadMap",
                dao.getOperatorWorkload()
        );

        request.setAttribute(
                "equipmentMap",
                dao.getEquipmentStatusReport()
        );

        RequestDispatcher rd =
                request.getRequestDispatcher("report.jsp");

        rd.forward(request, response);
    }
}