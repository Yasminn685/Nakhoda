package dao;

import model.User;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // =========================
    // LOGIN
    // =========================
    public User login(String email, String password, String role) {

        String sql = "SELECT userID, name, email, phoneNo, role "
                + "FROM `user` "
                + "WHERE email=? AND password=? AND role=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, role);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setUserID(rs.getString("userID"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhoneNo(rs.getString("phoneNo"));
                u.setRole(rs.getString("role"));
                return u;
            }

        } catch (Exception e) {
            System.out.println("=== LOGIN ERROR ===");
            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // CHECK EMAIL EXIST
    // =========================
    public boolean emailExists(String email) {

        String sql = "SELECT 1 FROM `user` WHERE email=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            System.out.println("=== EMAIL CHECK ERROR ===");
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // GENERATE USER ID
    // Manager -> M001
    // Supervisor -> S001
    // Operator -> O001
    // =========================
    public String generateNextUserID(String role) {

        String prefix = "U";

        if ("Manager".equalsIgnoreCase(role)) {
            prefix = "M";
        } else if ("Supervisor".equalsIgnoreCase(role)) {
            prefix = "S";
        } else if ("Operator".equalsIgnoreCase(role)) {
            prefix = "O";
        }

        String sql = "SELECT userID FROM `user` "
                + "WHERE userID LIKE ? "
                + "ORDER BY userID DESC LIMIT 1";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, prefix + "%");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String lastID = rs.getString("userID");
                int num = Integer.parseInt(lastID.substring(1));
                return String.format("%s%03d", prefix, num + 1);
            } else {
                return prefix + "001";
            }

        } catch (Exception e) {
            System.out.println("=== GENERATE USER ID ERROR ===");
            e.printStackTrace();
        }

        return prefix + "001";
    }

    // =========================
    // REGISTER
    // =========================
    public boolean register(User u) {

        String sql = "INSERT INTO `user` "
                + "(userID, name, email, phoneNo, password, role, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getUserID());
            ps.setString(2, u.getName());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhoneNo());
            ps.setString(5, u.getPassword());
            ps.setString(6, u.getRole());
            ps.setString(7, u.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("=== REGISTER ERROR ===");
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // GET USER BY ID
    // =========================
    public User getUserByID(String userID) {

        String sql = "SELECT * FROM `user` WHERE userID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userID);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getString("userID"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phoneNo"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // UPDATE PROFILE
    // =========================
    public boolean updateProfile(User u) {

        String sql = "UPDATE `user` SET name=?, email=?, phoneNo=? WHERE userID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhoneNo());
            ps.setString(4, u.getUserID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // CHANGE PASSWORD
    // =========================
    public boolean changePassword(String userID, String currentPass, String newPass) {

        String checkSql = "SELECT password FROM `user` WHERE userID=?";
        String updateSql = "UPDATE `user` SET password=? WHERE userID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(checkSql)) {

            ps.setString(1, userID);

            ResultSet rs = ps.executeQuery();

            if (!rs.next() || !rs.getString("password").equals(currentPass)) {
                return false;
            }

            try ( PreparedStatement ps2 = conn.prepareStatement(updateSql)) {
                ps2.setString(1, newPass);
                ps2.setString(2, userID);

                return ps2.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // GET ALL OPERATORS (WITH STATUS)
    // =========================
    public List<User> getAllOperators() {

        List<User> list = new ArrayList<>();

        String sql = "SELECT userID, name, email, phoneNo, role, status "
                + "FROM `user` WHERE role='operator'";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setUserID(rs.getString("userID"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhoneNo(rs.getString("phoneNo"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status"));

                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // COUNT OPERATORS (DASHBOARD KPI)
    // =========================
    public int countOperators(String condition) {

        String sql = "SELECT COUNT(*) FROM user WHERE role='operator' " + condition;

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // =========================
    // UPDATE STATUS (ACTIVE / INACTIVE)
    // =========================
    public boolean updateStatus(String userID, String status) {

        String sql = "UPDATE user SET status=? WHERE userID=? AND role='operator'";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, userID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    // =========================
// UPDATE USER (MANAGER)
// =========================

    public boolean updateUser(User u) {

        String sql = "UPDATE `user` "
                + "SET name=?, email=?, phoneNo=?, status=? "
                + "WHERE userID=?";

        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhoneNo());
            ps.setString(4, u.getStatus());
            ps.setString(5, u.getUserID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean resetPassword(String email, String newPassword) {

        String sql
                = "UPDATE user "
                + "SET password = ? "
                + "WHERE email = ?";

        try (
                 Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
