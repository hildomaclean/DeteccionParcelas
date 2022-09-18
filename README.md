# DeteccionParcelas
Detecta las parcelas de un experimento de quinua, las etiqueta y recupera los datos por pixel de cada parcela
Estos son dos scripts en formato *.m creados en lenguaje de programación MATLAB e implementados en el marco del proyecto de investigación: "FENOTIPAJE DE LA QUINUA DE VALLES INTERANDINOS A TRAVES DEL USO DE DRONES EQUIPADOS CON SENSORES DE ALTA RESOLUCION"

El algoritmo espera dos imágenes en formato *.tif, por ejemplo:
Turpay_210313_LeafChlorophyll_CUT_BIN_0.45_255_GRILLA.tif (Una imagen correspondiente al índice de vegetación OSAVI del experimento. Se presenta en formato binario:0 y 1. 0 corresponde al suelo y 1 a la vegetación. 
Turpay_210313_LeafChlorophyll_CUT_BIN_0.45_GRILLA.tif (Una imagen correspondiente del índice OSAVI del experimento en su formato original)

Se comparten dos files *.m:
Deteccion_Objetos_2.m
Función: Rota las imágenes aéreas, detecta las grillas de cada parcela de quinua utilizando geometrías rectangulares y las etiqueta para caracterizarlos.

Test_Final_1.m
Función: recupera la geometría de cada uno de los objetos detectados. Estos objetos corresponden a las parcelas. Cuenta el número de pixeles correspondientes a 1 (vegetación) y 0 (suelo). Seguidamente, recupera la información por pixel al interior de cada parcela.
