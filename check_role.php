<?php
session_start();

function checkRole($role){
    if(!isset($_SESSION['user'])){
        header("Location: login.php");
        exit();
    }

    if($_SESSION['user']['vai_tro'] != $role){
        header("Location: http://localhost/web_truyen_tranh/includes/error_user.php");
        exit();
    }
}  

function checkAdmin($role){
    if($_SESSION['user']['vai_tro'] == $role){
        header("Location: http://localhost/web_truyen_tranh/includes/error_admin.php");
        exit();
    }
}
?>