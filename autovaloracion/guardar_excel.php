<?php
require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

// Obtener los datos enviados por el formulario
$opcion = $_POST['opciones'];
$texto = $_POST['texto'];
$valor = $_POST['valor'];
$fecha = $_POST['fecha'];

// Crear una instancia del objeto Spreadsheet
$spreadsheet = new Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();

// Definir los encabezados de las columnas
$sheet->setCellValue('A1', 'Opción');
$sheet->setCellValue('B1', 'Texto');
$sheet->setCellValue('C1', 'Valor');
$sheet->setCellValue('D1', 'Fecha');

// Llenar los datos en las celdas
$sheet->setCellValue('A2', $opcion);
$sheet->setCellValue('B2', $texto);
$sheet->setCellValue('C2', $valor);
$sheet->setCellValue('D2', $fecha);

// Configurar el formato de las columnas
foreach (range('A', 'D') as $column) {
    $sheet->getColumnDimension($column)->setAutoSize(true);
}

// Guardar el archivo de Excel
$writer = new Xlsx($spreadsheet);
$writer->save('datos.xlsx');
?>
