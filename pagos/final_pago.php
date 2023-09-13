<?php
if (isset($_GET['amount']) && isset($_GET['userID'])) {
    $amount = $_GET['amount'];
    $userID = $_GET['userID'];

    $servername = "sql8.freemysqlhosting.net";
    $username = "sql8646243";
    $password = "iWtW2SekRP";
    $dbname = "sql8646243";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Conexión fallida: " . $conn->connect_error);
    }

    // Iniciar una transacción para realizar ambas operaciones de manera segura
    $conn->begin_transaction();

    try {
        // Actualizar la cantidad de créditos del usuario
        $sql_update = "UPDATE banco SET creditos = creditos - $amount WHERE userID = $userID";

        if ($conn->query($sql_update) !== TRUE) {
            throw new Exception("Error al actualizar créditos: " . $conn->error);
        }

        // Insertar en la tabla tiendaPublica con los valores proporcionados
        $tiendaID = 1478523699632581;
        $nombreTienda = "Supermercado Público";
        $timestamp = date("Y-m-d H:i:s");

        $sql_insert = "INSERT INTO tiendaPublica VALUES ($tiendaID, '$nombreTienda', $amount, $userID, '$timestamp')";

        if ($conn->query($sql_insert) !== TRUE) {
            throw new Exception("Error al insertar en tiendaPublica: " . $conn->error);
        }

        // Confirmar la transacción
        $conn->commit();
        echo "Operaciones exitosas.";
    } catch (Exception $e) {
        // Si ocurre algún error en alguna de las operaciones, realizar un rollback
        $conn->rollback();
        echo "Error: " . $e->getMessage();
    }

    // Cerrar la conexión a la base de datos
    $conn->close();
} else {
    echo "Faltan parámetros en la URL.";
}
?>
