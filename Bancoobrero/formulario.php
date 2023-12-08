<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Transacción</title>
</head>
<body>
    <h2>Formulario de Transacción</h2>
    
    <form method="post" action="generar_qr.php">
        <label for="n_cuenta">Número de Cuenta:</label>
        <input type="text" id="n_cuenta" name="n_cuenta" required><br>

        <label for="cantidad">Cantidad:</label>
        <input type="number" id="cantidad" name="cantidad" required><br>

        <button type="submit">Generar QR</button>
    </form>
</body>
</html>
