package dao;

import model.Task;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public List<Task> getAllTask() {
        List<Task> list = new ArrayList<>();

        String sql = "SELECT * FROM task ORDER BY taskID";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Task t = new Task(
                        rs.getString("taskID"),
                        rs.getString("taskName"),
                        rs.getString("taskDescription"),
                        rs.getString("taskStatus")
                );
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean addTask(Task t) {
        String sql = "INSERT INTO task (taskID, taskName, taskDescription, taskStatus) VALUES (?, ?, ?, ?)";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, t.getTaskID());
            ps.setString(2, t.getTaskName());
            ps.setString(3, t.getTaskDescription());
            ps.setString(4, t.getTaskStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteTask(String taskID) {
        String sql = "DELETE FROM task WHERE taskID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, taskID);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Task> getTaskByUser(String userID) {

        List<Task> list = new ArrayList<>();

        String sql
                = "SELECT t.taskID, t.taskName, t.taskDescription, t.taskStatus "
                + "FROM task t "
                + "JOIN roster r ON t.taskID = r.taskID "
                + "WHERE r.userID = ? "
                + "ORDER BY r.shiftDate ASC";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userID);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task t = new Task(
                        rs.getString("taskID"),
                        rs.getString("taskName"),
                        rs.getString("taskDescription"),
                        rs.getString("taskStatus")
                );
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateTaskStatus(String taskID, String status) {

        String sql = "UPDATE task SET taskStatus=? WHERE taskID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, taskID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public int countByStatus(String status) {

        String sql = "SELECT COUNT(*) FROM task WHERE taskStatus = ?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
    
    public Task getTaskByID(String taskID) {

    Task t = null;

    try (Connection conn = DBConnection.getConnection()) {

        String sql = "SELECT * FROM task WHERE taskID=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, taskID);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            t = new Task(
                rs.getString("taskID"),
                rs.getString("taskName"),
                rs.getString("taskDescription"),
                rs.getString("taskStatus")
            );
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return t;
}
}
