package dao;

import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class IndexDAO {

    // =========================
    // OPERATORS COUNT
    // =========================
    public int countOperators() {
        return getCount("SELECT COUNT(*) FROM operator");
    }

    // =========================
    // TASK COUNT
    // =========================
    public int countTasks() {
        return getCount("SELECT COUNT(*) FROM task");
    }

    // =========================
    // EQUIPMENT COUNT
    // =========================
    public int countEquipment() {
        return getCount("SELECT COUNT(*) FROM equipment");
    }

    // =========================
    // ROSTER COUNT
    // =========================
    public int countRosters() {
        return getCount("SELECT COUNT(*) FROM roster");
    }

    // =========================
    // GENERIC COUNT METHOD
    // =========================
    private int getCount(String sql) {

        int count = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}