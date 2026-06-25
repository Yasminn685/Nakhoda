package controller;

import dao.TaskDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateTaskStatus")
public class UpdateTaskStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String taskID = request.getParameter("taskID");
        String status = request.getParameter("status");

        TaskDAO dao = new TaskDAO();
        dao.updateTaskStatus(taskID, status);

        response.sendRedirect("myTask");
    }
}