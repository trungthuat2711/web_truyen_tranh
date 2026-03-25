<?php
session_start();

function checkRole($role){
    if(!isset($_SESSION['user'])){
        header("Location: login.php");
        exit();
    }

    if($_SESSION['user']['vai_tro'] != $role){
        header("Location: http://localhost/web_ban_truyen/includes/error_user.php");
        exit();
    }
}  

function checkNotAdmin(){
    if($_SESSION['user']['vai_tro'] == 'admin'){
        header("Location: http://localhost/web_ban_truyen/includes/error_admin.php");
        exit();
    }
}
?>