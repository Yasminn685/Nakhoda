package dao;
import model.Equipment;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EquipmentDAO {
    
    public List<Equipment> getAllEquipment() {
        List<Equipment> list = new ArrayList<>();

        String sql = "SELECT * FROM equipment ORDER BY equipmentCode";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Equipment e = new Equipment(
                        rs.getString("equipmentID"),
                        rs.getString("equipmentType"),
                        rs.getString("equipmentCode"),
                        rs.getString("equipmentStatus"),
                        rs.getString("location")
                );
                list.add(e);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
         return list;
    }

    public Equipment getEquipmentByID(String equipmentID) {
        Equipment e = null;

        String sql = "SELECT * FROM equipment WHERE equipmentID=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, equipmentID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                e = new Equipment(
                        rs.getString("equipmentID"),
                        rs.getString("equipmentType"),
                        rs.getString("equipmentCode"),
                        rs.getString("equipmentStatus"),
                        rs.getString("location")
                );
            }
        
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return e;
    }

    public boolean addEquipment(Equipment e) {
    String sql = "INSERT INTO equipment (equipmentID, equipmentType, equipmentCode, equipmentStatus, location) VALUES (?, ?, ?, ?, ?)";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        // Debug untuk tengok data apa yang masuk ke DAO
        System.out.println(">>> DAO cuba INSERT ID: " + e.getEquipmentID());

        ps.setString(1, e.getEquipmentID());
        ps.setString(2, e.getEquipmentType());
        ps.setString(3, e.getEquipmentCode());
        ps.setString(4, e.getEquipmentStatus());
        ps.setString(5, e.getLocation());

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;

    } catch (java.sql.SQLException ex) {
        System.out.println("\n==============================================");
        System.out.println("!!! PUNCA SEBENAR MYSQL REJECT:");
        System.out.println(">>> " + ex.getMessage());
        System.out.println("==============================================\n");
        ex.printStackTrace();
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    return false;
}

    public boolean updateEquipment(Equipment e) {
        String sql = "UPDATE equipment SET equipmentType=?, equipmentCode=?, " +
                     "equipmentStatus=?, location=? WHERE equipmentID=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, e.getEquipmentType());
            ps.setString(2, e.getEquipmentCode());
            ps.setString(3, e.getEquipmentStatus());
            ps.setString(4, e.getLocation());
            ps.setString(5, e.getEquipmentID());

            return ps.executeUpdate() > 0;

        } catch (Exception ex) {
            ex.printStackTrace();
        }    
        
        return false;
    }

    public boolean deleteEquipment(String equipmentID) {
        String sql = "DELETE FROM equipment WHERE equipmentID=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, equipmentID);
            return ps.executeUpdate() > 0;

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return false;
    }
    
    public int countByStatus(String status) {

        String sql = "SELECT COUNT(*) FROM equipment WHERE equipmentStatus = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
