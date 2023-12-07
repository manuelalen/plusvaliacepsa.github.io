-- Generar 1000 inserciones aleatorias
DELIMITER //

-- Inicio del script
CREATE PROCEDURE dr2()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE letras CHAR(26) DEFAULT 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    -- Bucle para realizar 1000 inserciones
    WHILE i < 1000 DO
        -- Generar valores aleatorios
        SET @dni = FLOOR(10000000 + RAND() * 90000000);
        SET @nombreCompleto = CONCAT('Usuario', i);
        SET @nCuenta = CONCAT('ES', LPAD(FLOOR(10000000000000000000000 + RAND() * 90000000000000000000000), 22, '0'));
        SET @creditos = FLOOR(1 + RAND() * 10000);
        SET @nivel = CHAR(65 + FLOOR(RAND() * 3)); -- 'A', 'B' o 'C'

        -- Obtener letra aleatoria para el DNI
        SET @letraDNI = SUBSTRING(letras, 1 + FLOOR(RAND() * 26), 1);

        -- Inserción de datos
        INSERT INTO dev_testeos.bancoobrero (DNI, NOMBRECOMPLETO, N_CUENTA, CREDITOS, NIVEL)
        VALUES (CONCAT(@dni, @letraDNI), @nombreCompleto, @nCuenta, @creditos, @nivel);

        -- Incrementar el contador
        SET i = i + 1;
    END WHILE;
END //

-- Fin del script
DELIMITER ;

-- Llamada al procedimiento para generar datos
CALL dr2();
