package controller;

import dao.EquipmentDAO;
import model.Equipment;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/equipmentAdd")
public class EquipmentAddServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String equipmentID = request.getParameter("equipmentID");
        String equipmentType = request.getParameter("equipmentType");
        String equipmentCode = request.getParameter("equipmentCode");
        String equipmentStatus = request.getParameter("equipmentStatus");
        String location = request.getParameter("location");

        if (equipmentID == null || equipmentID.trim().isEmpty()
                || equipmentType == null || equipmentType.trim().isEmpty()
                || equipmentCode == null || equipmentCode.trim().isEmpty()
                || equipmentStatus == null || equipmentStatus.trim().isEmpty()
                || location == null || location.trim().isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/equipmentList?err=1");
            return;
        }

        Equipment e = new Equipment(equipmentID, equipmentType, equipmentCode, equipmentStatus, location);
        EquipmentDAO dao = new EquipmentDAO();
        
        // Fokus jalankan INSERT sahaja
        boolean success = dao.addEquipment(e);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/equipmentList");
        } else {
            response.sendRedirect(request.getContextPath() + "/equipmentList?err=1");
        }
    }
}