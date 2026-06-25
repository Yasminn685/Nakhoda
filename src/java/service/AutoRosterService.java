package service;

import dao.RosterDAO;
import dao.UserDAO;
import model.User;

import java.time.LocalDate;
import java.util.*;

public class AutoRosterService {

    private RosterDAO rosterDAO = new RosterDAO();
    private UserDAO userDAO = new UserDAO();

    public void generateWeeklyRoster(LocalDate startDate) {

        List<User> operators = userDAO.getAllOperators();

        Map<String, Integer> nightCount = new HashMap<>();
        Map<String, Integer> workload = new HashMap<>();

        int operatorIndex = 0;

        for (int day = 0; day < 7; day++) {

            LocalDate date = startDate.plusDays(day);

            for (User op : operators) {

                String userID = op.getUserID();

                nightCount.putIfAbsent(userID, 0);
                workload.putIfAbsent(userID, 0);

                // SIMPLE ROTATION (FAIR DISTRIBUTION)
                if (operatorIndex >= operators.size()) {
                    operatorIndex = 0;
                }

                User assignedOp = operators.get(operatorIndex);

                String shiftName = assignShift(workload.get(userID));

                // RULE: max 2 night consecutive
                if (shiftName.equals("Night Shift") &&
                    nightCount.get(userID) >= 2) {
                    shiftName = "Morning Shift";
                }

                if (shiftName.equals("Night Shift")) {
                    nightCount.put(userID, nightCount.get(userID) + 1);
                } else {
                    nightCount.put(userID, 0);
                }

                rosterDAO.insertAutoRoster(
                        userID,
                        "AUTO-TASK",
                        shiftName,
                        date.toString()
                );

                workload.put(userID, workload.get(userID) + 1);

                operatorIndex++;
            }
        }
    }

    private String assignShift(int count) {

        if (count % 3 == 0) return "Morning Shift";
        if (count % 3 == 1) return "Evening Shift";
        return "Night Shift";
    }
}