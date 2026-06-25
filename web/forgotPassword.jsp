<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password | NAKHODA</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            background:#f4f6f9;
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
        }

        .card{
            background:white;
            padding:30px;
            width:400px;
            border-radius:12px;
            box-shadow:0 0 15px rgba(0,0,0,0.1);
        }

        h2{
            text-align:center;
            color:#003366;
        }

        input{
            width:100%;
            padding:12px;
            margin-top:10px;
            margin-bottom:15px;
            border:1px solid #ccc;
            border-radius:6px;
        }

        button{
            width:100%;
            padding:12px;
            background:#003366;
            color:white;
            border:none;
            border-radius:6px;
            cursor:pointer;
        }

        button:hover{
            background:#0055aa;
        }

        .msg{
            color:green;
            text-align:center;
            margin-top:10px;
        }

        .err{
            color:red;
            text-align:center;
            margin-top:10px;
        }

        a{
            display:block;
            text-align:center;
            margin-top:15px;
        }
    </style>
</head>

<body>

<div class="card">

    <h2>Reset Password</h2>

    <form action="ForgotPasswordServlet" method="post">

        <label>Email</label>
        <input type="email" name="email" required>

        <label>New Password</label>
        <input type="password"
               id="newPassword"
               name="newPassword"
               required
               minlength="8"
               onkeyup="checkStrength()"
               pattern="^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$"
               title="Min 8 characters, 1 uppercase, 1 number, 1 symbol">

        <div id="strengthText"></div>
        <progress id="strengthBar" value="0" max="100" style="width:100%;"></progress>

        <button type="submit">Update Password</button>

    </form>

    <!-- SUCCESS MESSAGE -->
    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if (success != null) {
    %>
        <p class="msg">
            Password updated successfully.
        </p>
    <%
        }
    %>

    <!-- ERROR MESSAGE -->
    <%
        if ("1".equals(error)) {
    %>
        <p class="err">
            Email not found.
        </p>
    <%
        } else if ("password".equals(error)) {
    %>
        <p class="err">
            Password must be at least 8 characters with 1 uppercase letter, 1 number, and 1 symbol.
        </p>
    <%
        }
    %>

    <a href="login.jsp">Back to Login</a>

</div>

<script>
function checkStrength() {
    let password = document.getElementById("newPassword").value;
    let strengthBar = document.getElementById("strengthBar");
    let strengthText = document.getElementById("strengthText");

    let strength = 0;

    if (password.length >= 8) strength += 25;
    if (password.match(/[A-Z]/)) strength += 25;
    if (password.match(/[0-9]/)) strength += 25;
    if (password.match(/[@#$%^&+=!]/)) strength += 25;

    strengthBar.value = strength;

    if (strength <= 25) {
        strengthText.innerHTML = "Weak";
        strengthText.style.color = "red";
    } else if (strength <= 50) {
        strengthText.innerHTML = "Fair";
        strengthText.style.color = "orange";
    } else if (strength <= 75) {
        strengthText.innerHTML = "Good";
        strengthText.style.color = "blue";
    } else {
        strengthText.innerHTML = "Strong";
        strengthText.style.color = "green";
    }
}
</script>

</body>
</html>