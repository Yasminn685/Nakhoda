/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Roster {
    private String rosterID;
    private String userID;
    private String taskID;
    private String shiftName;
    private String startTime;
    private String endTime;
    private String shiftDate;
    private String status;
    private String taskDescription;

    public Roster(String rosterID, String userID, String taskID, String shiftName, String startTime, String endTime, String shiftDate, String status) {
        this.rosterID = rosterID;
        this.userID = userID;
        this.taskID = taskID;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.shiftDate = shiftDate;
        this.status = status;
    }
    
    public Roster (){
        
    }

    public String getRosterID() {
        return rosterID;
    }

    public void setRosterID(String rosterID) {
        this.rosterID = rosterID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getTaskID() {
        return taskID;
    }

    public void setTaskID(String taskID) {
        this.taskID = taskID;
    }
    
    

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getShiftDate() {
        return shiftDate;
    }

    public void setShiftDate(String shiftDate) {
        this.shiftDate = shiftDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }
    
    
}