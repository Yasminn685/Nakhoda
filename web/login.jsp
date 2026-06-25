<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NAKHODA Login</title>
    <link rel="stylesheet" href="assets/css/login.css">
</head>
<body>

<div class="container">

    <div class="left">
        <div class="brand">
            <div class="brand-icon">⚓</div>
            <div class="brand-text">NAKHODA</div>
        </div>
    </div>

    <div class="right">
        <div class="form-card">

            <h1>Welcome back to<br><span>NAKHODA</span></h1>
            <p class="subtitle">Manage your port operations efficiently.</p>

            <form action="login" method="post">

                <label>Email Address</label>
                <div class="input-wrap">
                    <span class="icon">✉</span>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>

                <div class="row-between">
                    <label>Password</label>
                    <a class="link" href="forgotPassword.jsp">Forgot Password?</a>
                </div>

                <div class="input-wrap">
                    <span class="icon">🔒</span>
                    <input type="password" name="password" id="passwordField" placeholder="Enter your password" required>
                    <button type="button" class="eye" onclick="togglePwd()">👁</button>
                </div>

                <label>Login As</label>
                <div class="input-wrap">
                    <span class="icon">👤</span>
                    <select name="role" required>
                        <option value="" selected disabled>Select role</option>
                        <option value="Manager">Manager</option>
                        <option value="Supervisor">Supervisor</option>
                        <option value="Operator">Operator</option>
                    </select>
                </div>

                <div class="remember">
                    <input type="checkbox" id="remember">
                    <label for="remember">Remember this device</label>
                </div>

                <button class="btn" type="submit">Log In →</button>

                <div class="divider"></div>

                <p class="small">
                    Don’t have an account yet? <a class="link" href="register.jsp">Create an Account</a>
                </p>
                
                <% if(request.getParameter("registered") != null){ %>
                    <p class="success" style="color: green; font-size: 0.8em; margin-top: 10px;">
                        Account created. Please login.
                    </p>
                <% } %>

                <%
                    String err = request.getParameter("err");
                    if (err != null) {
                %>
                    <p class="error" style="color: red; font-size: 0.8em; margin-top: 10px;">
                        Invalid email, password, or role. Please try again.
                    </p>
                <%
                    }
                %>

            </form>
        </div>
    </div>

</div>

<script>
function togglePwd(){
    const pwd = document.getElementById('passwordField');
    pwd.type = (pwd.type === "password") ? "text" : "password";
}
</script>

</body>
</html>