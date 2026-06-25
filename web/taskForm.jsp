<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Task | NAKHODA</title>
        <link rel="stylesheet" href="assets/css/dashboard.css">
    </head>
    <body>
        <div class="layout">
            <main class="content" style="padding:40px; max-width:800px; margin:auto;">
                <section class="card">
                    <h2>Add New Task</h2>

                    <form action="taskAdd" method="post">
                        <div class="form-grid">
                            <div class="input">
                                <label>Task ID</label>
                                <input type="text" name="taskID" required>
                            </div>

                            <div class="input">
                                <label>Task Name</label>
                                <input type="text" name="taskName" required>
                            </div>

                            <div class="input" style="grid-column:1/-1;">
                                <label>Description</label>
                                <textarea name="taskDescription"></textarea>
                            </div>

                            <div class="input">
                                <label>Status</label>
                                <select name="taskStatus">
                                    <option value="Pending">Pending</option>
                                    <option value="Active">Active</option>
                                    <option value="Completed">Completed</option>
                                </select>
                            </div>
                        </div>

                        <div style="margin-top:20px; display:flex; gap:10px;">
                            <button class="btn" type="submit">Save Task</butto