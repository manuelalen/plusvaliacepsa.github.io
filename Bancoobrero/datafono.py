import cv2
from pyzbar.pyzbar import decode
import mysql.connector

# Establece la conexión a la base de datos
conexion_db = mysql.connector.connect(
    host="localhost",
    user="manolito",
    password="manolito",
    database="dev_testeos",
    autocommit=True  # Habilita el commit automático
)

def leer_qr(imagen):
    # Decodificar códigos QR
    codigos_qr = decode(imagen)
    for codigo in codigos_qr:
        # Extraer la información del código QR
        datos = codigo.data.decode('utf-8').strip()  # Eliminar espacios al principio y al final
        tipo = codigo.type
        # Mostrar la información en la consola
        print(f'Tipo: {tipo}, Datos: {datos}')

        # Dividir la información del QR en número de tarjeta y cantidad de dinero
        partes = list(map(str.strip, datos.split('|')))
        if len(partes) == 2:
            numero_tarjeta, cantidad_dinero = partes
            print("Antes de la conversión:")
            print(f'Número de tarjeta: {numero_tarjeta}, Cantidad de dinero: {cantidad_dinero}')

            # Actualizar la base de datos con la información del QR
            actualizar_base_datos(numero_tarjeta, cantidad_dinero)

            # Mostrar la información en una ventana
            cv2.putText(imagen, datos, (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

    return imagen






def actualizar_base_datos(numero_tarjeta, cantidad_dinero):
    # Construir la consulta SQL
    consulta_sql = f"UPDATE dev_testeos.bancoobrero SET CREDITOS = CREDITOS - {cantidad_dinero} WHERE N_CUENTA = '{numero_tarjeta}';"

    # Ejecutar la consulta
    cursor = conexion_db.cursor()
    try:
        cursor.execute(consulta_sql)
        conexion_db.commit()
        print("Actualización exitosa")
        print(f"Consulta SQL: {consulta_sql}")
        print(f"Filas afectadas: {cursor.rowcount}")
        cursor.execute("SELECT * FROM dev_testeos.bancoobrero WHERE N_CUENTA = '{numero_tarjeta}';")
        resultados = cursor.fetchall()
        print(resultados)

    except Exception as e:
        print(f"Error al ejecutar la consulta: {str(e)}")
    finally:
        cursor.close()



def ha_leido_qr(fotograma_con_qr):
    # Aquí deberías poner la lógica para determinar si se ha leído un código QR
    # Puedes basarte en alguna condición específica del código QR leído

    # Obtener los códigos QR del fotograma
    codigos_qr = decode(fotograma_con_qr)

    # Verificar si se ha leído al menos un código QR
    if codigos_qr:
        # Supongamos que consideramos válido cualquier código QR leído
        return True

    return False


def main():
    # Iniciar la captura de la webcam
    captura = cv2.VideoCapture(0)

    while True:
        # Capturar un fotograma de la webcam
        _, fotograma = captura.read()

        # Llamar a la función para leer códigos QR
        fotograma_con_qr = leer_qr(fotograma)

        # Mostrar la imagen en una ventana
        cv2.imshow('Webcam QR', fotograma_con_qr)

        # Salir del bucle si se ha leído un código QR
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

        # Verificar si se ha leído un código QR y cerrar la webcam
        if ha_leido_qr(fotograma_con_qr):
            break

    # Liberar la captura y cerrar la ventana
    captura.release()
    cv2.destroyAllWindows()
    # Cerrar la conexión a la base de datos
    conexion_db.close()



if __name__ == "__main__":
    main()
