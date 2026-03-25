<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    .marquee {
        width: 100%;
        overflow: hidden;
        white-space: nowrap;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    .marquee a {
        font-size: 40px;
        display: inline-block;
        padding-left: 100%;
        animation: scroll 10s linear infinite;
    }

    @keyframes scroll {
        from {
            transform: translateX(0);
        }

        to {
            transform: translateX(-100%);
        }
    }
    </style>
</head>

<body>
    <div class="marquee">
        <a href="/web_ban_truyen/admin.php">QUAY VỀ TRANG ADMIN !!!</a>
    </div>
</body>

</html>