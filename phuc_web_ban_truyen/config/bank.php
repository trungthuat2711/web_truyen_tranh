<?php
return json_decode(file_get_contents(__DIR__ . '/bank.json'), true) ?: [];