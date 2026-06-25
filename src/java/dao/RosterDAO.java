/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Roster;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RosterDAO {

    public List<Roster> getAllRoster() {
        List<Roster> list = new ArrayList<>();

        String sql = "SELECT rosterID, userID, taskID, shiftName, startTime, endTime, shiftDate, status FROM roster ORDER BY shiftDate DESC, startTime ASC";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Roster r = new Roster(
                        rs.getString("rosterID"),
                        rs.getString("userID"),
                        rs.getString("taskID"),
                        rs.getString("shiftName"),
                        rs.getString("startTime"),
                        rs.getString("endTime"),
                        rs.getString("shiftDate"),
                        rs.getString("status")
                );
                list.add(r);
            }

        } catch (Exception e) {
            System.out.println("RosterDAO.getAllRoster error");
            e.printStackTrace();
        }

        return list;
    }

    public boolean addRoster(Roster r) {

        String sql = "INSERT INTO roster "
                + "(rosterID, userID, taskID, shiftName, startTime, endTime, shiftDate, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getRosterID());
            ps.setString(2, r.getUserID());
            ps.setString(3, r.getTaskID());
            ps.setString(4, r.getShiftName());
            ps.setString(5, r.getStartTime());
            ps.setString(6, r.getEndTime());
            ps.setDate(7, java.sql.Date.valueOf(r.getShiftDate()));
            ps.setString(8, r.getStatus());

            int rows = ps.executeUpdate();

            System.out.println("✔ Roster inserted rows: " + rows);

            return rows > 0;

        } catch (Exception e) {
            System.out.println("❌ addRoster FAILED");
            e.printStackTrace(); // IMPORTANT
        }

        return false;
    }

    public boolean deleteRoster(String rosterID) {
        String sql = "DELETE FROM roster WHERE rosterID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, rosterID);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("RosterDAO.deleteRoster error");
            e.printStackTrace();
        }

        return false;
    }

    public List<Roster> getPendingRoster() {
        List<Roster> list = new ArrayList<>();

        String sql = "SELECT * FROM roster WHERE status='Assigned'";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Roster r = new Roster(
                        rs.getString("rosterID"),
                        rs.getString("userID"),
                        rs.getString("taskID"),
                        rs.getString("shiftName"),
                        rs.getString("startTime"),
                        rs.getString("endTime"),
                        rs.getString("shiftDate"),
                        rs.getString("status")
                );
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateRosterStatus(String rosterID, String status) {

        String sql = "UPDATE roster SET status=? WHERE rosterID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, rosterID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Roster> getRosterByUser(String userID) {

        List<Roster> list = new ArrayList<>();

        String sql
                = "SELECT * FROM roster "
                + "WHERE userID=? "
                + "ORDER BY shiftDate ASC";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userID);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Roster r = new Roster(
                        rs.getString("rosterID"),
                        rs.getString("userID"),
                        rs.getString("taskID"),
                        rs.getString("shiftName"),
                        rs.getString("startTime"),
                        rs.getString("endTime"),
                        rs.getString("shiftDate"),
                        rs.getString("status")
                );

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    public Roster getRosterByID(String rosterID) {

        String sql = "SELECT * FROM roster WHERE rosterID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, rosterID);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return new Roster(
                        rs.getString("rosterID"),
                        rs.getString("userID"),
                        rs.getString("taskID"),
                        rs.getString("shiftName"),
                        rs.getString("startTime"),
                        rs.getString("endTime"),
                        rs.getString("shiftDate"),
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean generateWeeklyRoster(String taskID,
            String shiftName,
            String startTime,
            String endTime,
            java.sql.Date startDate) {

        String sql = "INSERT INTO roster "
                + "(rosterID, userID, taskID, shiftName, startTime, endTime, shiftDate, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            List<String> operators = getAllOperatorIDs();

            for (String userID : operators) {

                for (int i = 0; i < 7; i++) {

                    java.sql.Date shiftDate
                            = new java.sql.Date(startDate.getTime() + (i * 86400000L));

                    String rosterID = "R" + System.currentTimeMillis() + i;

                    ps.setString(1, rosterID);
                    ps.setString(2, userID);
                    ps.setString(3, taskID);
                    ps.setString(4, shiftName);
                    ps.setString(5, startTime);
                    ps.setString(6, endTime);
                    ps.setDate(7, shiftDate);
                    ps.setString(8, "Assigned");

                    ps.executeUpdate();
                }
            }

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<String> getAllOperatorIDs() {

        List<String> list = new ArrayList<>();

        String sql = "SELECT userID FROM user WHERE role='operator'";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(rs.getString("userID"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean isUserExists(String userID) {

        String sql = "SELECT 1 FROM user WHERE userID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userID);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isOperatorAssigned(String userID, String shiftDate) {

        String sql
                = "SELECT COUNT(*) FROM roster "
                + "WHERE userID=? AND shiftDate=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userID);
            ps.setString(2, shiftDate);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isTaskExists(String taskID) {

        String sql = "SELECT 1 FROM task WHERE taskID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, taskID);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isTaskAssigned(String taskID, String shiftDate) {

        String sql
                = "SELECT COUNT(*) FROM roster "
                + "WHERE taskID=? AND shiftDate=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, taskID);
            ps.setString(2, shiftDate);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public List<Roster> getTodayRoster() {

    List<Roster> list = new ArrayList<>();

    String sql = "SELECT * FROM roster WHERE shiftDate = CURDATE()";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {

            Roster r = new Roster(
                    rs.getString("rosterID"),
                    rs.getString("userID"),
                    rs.getString("taskID"),
                    rs.getString("shiftName"),
                    rs.getString("startTime"),
                    rs.getString("endTime"),
                    rs.getString("shiftDate"),
                    rs.getString("status")
            );

            list.add(r);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
    
    public boolean insertAutoRoster(String userID, String taskID, String shiftName, String date) {

    String sql = "INSERT INTO roster (rosterID, userID, taskID, shiftName, startTime, endTime, shiftDate, status) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, "R" + System.currentTimeMillis());
        ps.setString(2, userID);
        ps.setString(3, taskID);
        ps.setString(4, shiftName);

        // FIXED SHIFT TIME (NO MANUAL)
        if (shiftName.equals("Morning Shift")) {
            ps.setString(5, "08:00");
            ps.setString(6, "16:00");
        } else if (shiftName.equals("Evening Shift")) {
            ps.setString(5, "16:00");
            ps.setString(6, "00:00");
        } else {
            ps.setString(5, "00:00");
            ps.setString(6, "08:00");
        }

        ps.setDate(7, java.sql.Date.valueOf(date));
        ps.setString(8, "Assigned");

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
    
}
