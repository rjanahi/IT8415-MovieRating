<?php
session_start();
require_once '../includes/db_connect.php';

$error = "";
$success = "";

if (isset($_POST['signup'])) {
    $full_name = trim($_POST['full_name']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    if (empty($full_name)) {
        $error = "Full name is required.";
    } elseif (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "A valid email is required.";
    } elseif (strlen($password) < 8) {
        $error = "Password must be at least 8 characters.";
    } elseif ($password !== $confirm_password) {
        $error = "Passwords do not match.";
    } else {
        $stmt = $pdo->prepare("SELECT user_id FROM dbProj_users WHERE email = ?");
        $stmt->execute([$email]);
        if ($stmt->rowCount() > 0) {
            $error = "Email is already registered.";
        } else {
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("INSERT INTO dbProj_users (full_name, email, password_hash, role_id) VALUES (?, ?, ?, 3)");
            $stmt->execute([$full_name, $email, $hashed_password]);
            $success = "Account created successfully! You can now log in.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - MovieRating</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .form-card { background: #ffffff; border: 1px solid #e0e0e0; border-radius: 12px; padding: 2rem; width: 100%; max-width: 400px; }
        .logo { font-size: 18px; font-weight: bold; color: #1a1a1a; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 8px; }
        .logo-icon { width: 28px; height: 28px; background: #1a1a1a; border-radius: 6px; display: flex; align-items: center; justify-content: center; }
        .form-title { font-size: 22px; font-weight: bold; color: #1a1a1a; margin-bottom: 0.25rem; }
        .form-subtitle { font-size: 14px; color: #666; margin-bottom: 1.5rem; }
        .form-group { margin-bottom: 1rem; }
        .form-label { display: block; font-size: 13px; font-weight: bold; color: #444; margin-bottom: 6px; }
        .form-input { width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 8px; font-size: 14px; color: #1a1a1a; background: #fafafa; }
        .form-input:focus { outline: none; border-color: #888; background: #fff; }
        .form-btn { width: 100%; padding: 10px; border-radius: 8px; border: none; background: #1a1a1a; color: #fff; font-size: 15px; font-weight: bold; cursor: pointer; margin-top: 0.5rem; }
        .form-btn:hover { background: #333; }
        .form-link { text-align: center; font-size: 13px; color: #666; margin-top: 1rem; }
        .form-link a { color: #1a1a1a; font-weight: bold; text-decoration: none; }
        .error-msg { color: red; font-size: 12px; margin-top: 4px; display: block; }
        .alert-error { background: #ffe0e0; border: 1px solid #ffaaaa; color: #cc0000; padding: 10px 12px; border-radius: 8px; font-size: 14px; margin-bottom: 1rem; }
        .alert-success { background: #e0ffe0; border: 1px solid #aaffaa; color: #007700; padding: 10px 12px; border-radius: 8px; font-size: 14px; margin-bottom: 1rem; }
    </style>
</head>
<body>

<div class="form-card">
    <div class="logo">
        <div class="logo-icon">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <path d="M8 2L10 6H14L11 9L12 13L8 11L4 13L5 9L2 6H6L8 2Z" fill="white"/>
            </svg>
        </div>
        MovieRating
    </div>

    <p class="form-title">Create an account</p>
    <p class="form-subtitle">Join to rate and review movies</p>

    <?php if ($error): ?>
        <div class="alert-error"><?php echo $error; ?></div>
    <?php endif; ?>
    <?php if ($success): ?>
        <div class="alert-success"><?php echo $success; ?></div>
    <?php endif; ?>

    <form action="signup.php" method="POST">
        <div class="form-group">
            <label class="form-label">Full name</label>
            <input class="form-input" type="text" name="full_name" id="full_name" placeholder="John Doe">
            <span class="error-msg" id="name_error"></span>
        </div>
        <div class="form-group">
            <label class="form-label">Email</label>
            <input class="form-input" type="email" name="email" id="email" placeholder="you@example.com">
            <span class="error-msg" id="email_error"></span>
        </div>
        <div class="form-group">
            <label class="form-label">Password</label>
            <input class="form-input" type="password" name="password" id="password" placeholder="Min. 8 characters">
            <span class="error-msg" id="pass_error"></span>
        </div>
        <div class="form-group">
            <label class="form-label">Confirm password</label>
            <input class="form-input" type="password" name="confirm_password" id="confirm_password" placeholder="Repeat your password">
            <span class="error-msg" id="confirm_error"></span>
        </div>
        <button class="form-btn" type="submit" name="signup">Sign up</button>
    </form>

    <p class="form-link">Already have an account? <a href="login.php">Log in</a></p>
</div>

<script>
document.querySelector("form").addEventListener("submit", function(e) {
    let valid = true;

    let fullName = document.getElementById("full_name").value.trim();
    if (fullName === "") {
        document.getElementById("name_error").textContent = "Full name is required.";
        valid = false;
    } else {
        document.getElementById("name_error").textContent = "";
    }

    let email = document.getElementById("email").value.trim();
    if (email === "") {
        document.getElementById("email_error").textContent = "Email is required.";
        valid = false;
    } else {
        document.getElementById("email_error").textContent = "";
    }

    let password = document.getElementById("password").value;
    if (password.length < 8) {
        document.getElementById("pass_error").textContent = "Password must be at least 8 characters.";
        valid = false;
    } else {
        document.getElementById("pass_error").textContent = "";
    }

    let confirm = document.getElementById("confirm_password").value;
    if (confirm !== password) {
        document.getElementById("confirm_error").textContent = "Passwords do not match.";
        valid = false;
    } else {
        document.getElementById("confirm_error").textContent = "";
    }

    if (!valid) e.preventDefault();
});
</script>

</body>
</html>