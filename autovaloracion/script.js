function generateExcel() {
  // Obtener los valores de los campos del formulario
  var option = document.getElementById('selectOption').value;
  var text = document.getElementById('textInput').value;
  var number = document.getElementById('numberInput').value;
  var date = document.getElementById('dateInput').value;

  // Crear un objeto de datos con los valores
  var data = {
    option: option,
    text: text,
    number: number,
    date: date
  };

  // Convertir el objeto de datos a formato JSON
  var jsonData = JSON.stringify(data);

  // Crear un enlace de descarga para el archivo Excel
  var a = document.createElement('a');
  a.href = 'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,' + btoa(jsonData);
  a.download = 'datos.xlsx';
  a.click();
}
