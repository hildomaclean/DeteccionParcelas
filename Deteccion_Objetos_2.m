clear all
close all
im1=imread('Turpay_210313_LeafChlorophyll_CUT_BIN_0.45_255_GRILLA.tif');
im2=imread('Turpay_210313_LeafChlorophyll_CUT_BIN_0.45_GRILLA.tif');
rota_im1=imrotate(im1,8,'bilinear');
rota_im2=imrotate(im2,8,'bilinear');

% la imagen que he introducido es una RGB la cual fue cortada utilizando la
% grilla 1. Ademas la lleve al formato de 0 - 255, considerando que 0.1 es 255 en las 
% imagenes RGB reconstruidas del Pix4D (imagenes de reflectancia)
% La funcion rb2gray, como input exige imagenes RGF 03 bandas.
%
%  El objetivo de este codigo es detectar c/u de las parcelas, etiquetrlas
%  y RECUPERAR los vertices de los rectangulos que encierran cada uno de
%  los plots. 

%i1=imread('Turpay_210313_LeafChlorophyll_CUT_BIN_0.45_255_GRILLA_8.jpg');
%i1g=rgb2gray(i1);
%bw1=im2bw(i1);
bw1=im2bw(rota_im1);
%i2=imread('20191129_40m_index_ndvi_CUT_Grid1_255.tif');
%bw2=im2bw(i2);

% Se necesita que i1 sea una imagen que contenga todas las grillas, si
% ingresamos plots con valores de CERO, el algortimo de deteccion de objetos
% agrupara cada uno de los pequeños retazos de informacion.
% Deberia funcionar con: 20191129_40m_index_ndvi_CUT cortada con GRILLA 1 y
% escalada al formato 0-255. Ya que rgb2gray exige 3 bandas como input,
% utilizo directammnete la funcion im2bw. Al final, 

stats=regionprops(bw1,'Perimeter','Area','Centroid','BoundingBox');
%figure(1),imshow(bw2)

%ndvi1=imread('Turpay_210313_LeafChlorophyll_CUT_BIN_0.45_GRILLA_8.jpg');
% ndvi1 es la imagen NDVI - exp 2019 filtrada con OSAVI y cortada con la grilla 1.
figure(1),imshow(rota_im2);
hold on

for k=1:length(stats)
    thisboundingbox=stats(k).BoundingBox;   
    rectangle('Position',[thisboundingbox(1),thisboundingbox(2),thisboundingbox(3),thisboundingbox(4)],'EdgeColor','b','Linewidth',0.5);
    text(stats(k).Centroid(1),stats(k).Centroid(2),num2str(k),'Color','r','FontSize',6);
end



% Este etapa recupera las coordenadas de los verticies del rectangulo mas
% pequeño que atrapa a los objetos detctados.
% area1: guarda las coordenadas de c/u de los rectangulos y aproxima sus
% valores al numero entero proximo 

for k=1:length(stats)
    thisboundingbox=stats(k).BoundingBox;
    for j=1:4
        area(k,j)=thisboundingbox(j);
        area1(k,j)=round(area(k,j));
    end 
end

% area2: guarda los coordenadas de los vertices de los rectangulos en el orden apropiado, para
%recuperar ordenadamente los vertices de cada plot Segun:
% area2(k,1) = area1(k,1) = X1
% area2(k,2) = area1(k,2) = Y1
% area2(k,3) = area1(k,1) + area1(k,3) = X2
% area2(k,4) = area1(k,4) + area1(k,2) = Y2

for k=1:length(stats)
    area2(k,1)=area1(k,1);%(x1)
    area2(k,2)=area1(k,2);%(y1)
    area2(k,3)=area1(k,3)+area1(k,1)-1;%(x2)
    area2(k,4)=area1(k,4)+area1(k,2)-1;%(y2)          
end
