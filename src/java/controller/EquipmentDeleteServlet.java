package controller;

import dao.EquipmentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/equipmentDelete")
public class EquipmentDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String equipmentID = request.getParameter("equipmentID");

        EquipmentDAO dao = new EquipmentDAO();
        dao.deleteEquipment(equipmentID);

        response.sendRedirect("equipmentList");
    }
}