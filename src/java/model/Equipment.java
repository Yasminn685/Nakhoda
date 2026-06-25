/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author yasmi
 */
public class Equipment {
    
    private String equipmentID;
    private String equipmentType;
    private String equipmentCode;
    private String equipmentStatus;
    private String location;

    public Equipment() {
    }

    public Equipment(String equipmentID, String equipmentType,
                     String equipmentCode, String equipmentStatus,
                     String location) {
        this.equipmentID = equipmentID;
        this.equipmentType = equipmentType;
        this.equipmentCode = equipmentCode;
        this.equipmentStatus = equipmentStatus;
        this.location = location;
    }

    public String getEquipmentID() {
        return equipmentID;
    }

    public void setEquipmentID(String equipmentID) {
        this.equipmentID = equipmentID;
    }

    public String getEquipmentType() {
        return equipmentType;
    }

    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }

    public String getEquipmentCode() {
        return equipmentCode;
    }

    public void setEquipmentCode(String equipmentCode) {
        this.equipmentCode = equipmentCode;
    }

    public String getEquipmentStatus() {
        return equipmentStatus;
    }

    public void setEquipmentStatus(String equipmentStatus) {
        this.equipmentStatus = equipmentStatus;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}