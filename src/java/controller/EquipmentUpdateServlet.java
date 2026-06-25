package controller;

import dao.EquipmentDAO;
import model.Equipment;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/equipmentUpdate")
public class EquipmentUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String equipmentID = request.getParameter("equipmentID");
        String equipmentType = request.getParameter("equipmentType");
        String equipmentCode = request.getParameter("equipmentCode");
        String equipmentStatus = request.getParameter("equipmentStatus");
        String location = request.getParameter("location");

        Equipment e = new Equipment(equipmentID, equipmentType, equipmentCode, equipmentStatus, location);
        EquipmentDAO dao = new EquipmentDAO();
        
        // Fokus jalankan UPDATE sahaja
        boolean success = dao.updateEquipment(e);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/equipmentList");
        } else {
            response.sendRedirect(request.getContextPath() + "/equipmentList?err=1");
        }
    }
}