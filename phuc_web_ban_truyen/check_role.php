<?php
session_start();

function checkRole($role){
    if(!isset($_SESSION['user'])){
        header("Location: login.php");
        exit();
    }

    if($_SESSION['user']['vai_tro'] != $role){
        echo "Bạn không có quyền truy cập trang này!";
        exit();
    }
}
?>