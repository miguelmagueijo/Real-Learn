<?php

    function mostraAlert($msg) {
        echo "
            <script>
                alert('".$msg."');
            </script>
        ";
    }

    function gotoFormGestao() {
        echo "
            <script type='text/javascript'>
                window.location.href = '../formGestao.php';
            </script>
        ";
    }

?>