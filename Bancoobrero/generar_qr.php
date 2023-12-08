<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $n_cuenta = $_POST["n_cuenta"];
    $cantidad = $_POST["cantidad"];

    // Crear texto para el código QR
    $texto_qr = $n_cuenta . " | " . $cantidad;

    // Generar código QR
    include('phpqrcode/qrlib.php');
    QRcode::png($texto_qr);
} else {
    // Redirigir si no se ha enviado el formulario
    header("Location: formulario.php");
    exit();
}
?>
