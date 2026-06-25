package dao;

import util.DBConnection;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class ReportDAO {

    // ================= KPI =================

    public int countOperators() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM user " +
                "WHERE role='Operator'";

        return count(sql);
    }

    public int countActiveOperators() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM user " +
                "WHERE role='Operator' " +
                "AND status='Active'";

        return count(sql);
    }

    public int countTasks() {

        return count(
                "SELECT COUNT(*) FROM task"
        );
    }

    public int countCompletedTasks() {

        return count(
                "SELECT COUNT(*) " +
                "FROM task " +
                "WHERE taskStatus='Completed'"
        );
    }

    public int countRosters() {

        return count(
                "SELECT COUNT(*) FROM roster"
        );
    }

    // ================= TASK STATUS REPORT =================

    public Map<String,Integer> getTaskStatusReport(){

        Map<String,Integer> map =
                new LinkedHashMap<>();

        String sql =
                "SELECT taskStatus, COUNT(*) total " +
                "FROM task " +
                "GROUP BY taskStatus";

        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while(rs.next()){

                map.put(
                        rs.getString("taskStatus"),
                        rs.getInt("total")
                );
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return map;
    }

    // ================= EQUIPMENT STATUS REPORT =================

    public Map<String,Integer> getEquipmentStatusReport(){

        Map<String,Integer> map =
                new LinkedHashMap<>();

        String sql =
                "SELECT equipmentStatus, COUNT(*) total " +
                "FROM equipment " +
                "GROUP BY equipmentStatus";

        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while(rs.next()){

                map.put(
                        rs.getString("equipmentStatus"),
                        rs.getInt("total")
                );
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return map;
    }

    // ================= OPERATOR WORKLOAD =================

    public Map<String,Integer> getOperatorWorkload(){

        Map<String,Integer> map =
                new LinkedHashMap<>();

        String sql =
                "SELECT u.name, COUNT(r.rosterID) total " +
                "FROM user u " +
                "LEFT JOIN roster r ON u.userID = r.userID " +
                "WHERE u.role='Operator' " +
                "GROUP BY u.userID, u.name " +
                "ORDER BY total DESC";

        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while(rs.next()){

                map.put(
                        rs.getString("name"),
                        rs.getInt("total")
                );
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return map;
    }

    // ================= HELPER =================

    private int count(String sql){

        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            if(rs.next()){
                return rs.getInt(1);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return 0;
    }
}