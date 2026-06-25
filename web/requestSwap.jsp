<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Request Roster Swap | NAKHODA</title>

    <style>
        body{
            font-family:Arial;
            margin:0;
            background:#f5f7fb;
        }

        .top{
            background:#0b2a4a;
            color:white;
            padding:16px 24px;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .container{
            padding:24px;
        }

        .card{
            background:white;
            border-radius:14px;
            padding:24px;
            box-shadow:0 10px 24px rgba(0,0,0,.06);
            max-width:700px;
            margin:auto;
        }

        label{
            display:block;
            margin-top:14px;
            margin-bottom:6px;
            font-weight:bold;
        }

        input, select, textarea{
            width:100%;
            padding:10px;
            border-radius:8px;
            border:1px solid #ccc;
        }

        .btn{
            background:#1e88e5;
            color:white;
            padding:10px 16px;
            border:none;
            border-radius:10px;
            cursor:pointer;
            margin-top:18px;
        }

        .btn.gray{
            background:#445;
            text-decoration:none;
            display:inline-block;
        }
    </style>
</head>
<body>

<div class="top">
    <div><b>NAKHODA</b> — Request Roster Swap</div>

    <a href="myRoster.jsp" class="btn gray">
        Back
    </a>
</div>

<div class="container">

    <div class="card">

        <h2>Roster Swap Request</h2>

        <form>

            <label>Current Roster</label>
            <input type="text" value="Morning Operations - 20 Jan 2026" readonly>

            <label>Swap With</label>
            <select>
                <option>Select Operator</option>
                <option>U0002 - Nur Aina</option>
                <option>U0003 - Hafiz</option>
            </select>

            <label>Reason</label>
            <textarea rows="4" placeholder="Enter reason for swap request..."></textarea>

            <button type="submit" class="btn">
                Submit Request
            </button>

        </form>

    </div>

</div>

</body>
</html>