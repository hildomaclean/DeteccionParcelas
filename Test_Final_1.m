%clear all
%close all
% Este bucle captura la informacion de cada plot con el orden correcto como
% se representa como imagen (Y,X). Ademas se genera una nueva distribcuion
% iniciando de (1,1)

% ndvi1=imread('20191129_40m_ndvi_CUT_BIN_027_FILTER_GRID1.tif');
% ndvi1 es la imagen NDVI - exp 2019 filtrada con OSAVI y cortada con la grilla 1.
% Tomar en cuenta que el tamaño de esta imagen es identica a la imagen RGB
% que se utilizo en el codigo: Deteccion_Objetos.m


cer1(1:length(stats))=0;       
nul1(1:length(stats))=0;    
plan1(1:length(stats))=0;  

for k=1:length(stats)
   
    n=1;% ESTO ES Y
    largorec(k)=area2(k,3)-area2(k,1)+1;
    %largorec(k): es el largo de un rectangulo que contiene al objeto
    anchorec(k)=area2(k,4)-area2(k,2)+1;
    %anchorec(k): es el ancho de un rectangulo que contiene al objeto
    totpix1(k)=largorec(k)*anchorec(k);
    %Total Pixeles en cada rectangulo que detecta objetos
    
    ii=1;
    for i=1:area2(k,3)-area2(k,1)+1 % En la matriz el X es el Y
        
         m=1;%ESTO ES X
    
        for j=1:area2(k,4)-area2(k,2)+1 % En la matriz el Y es el X
            gri1(n,m,k)= rota_im2(j+area2(k,2)-1,i+area2(k,1)-1);
            
            if gri1(n,m,k)<0                
                nul1(k)=nul1(k)+1;
                % nul(k): son los pixeles al intetriro del rectangulo que deteccata 
                % objetos y que no tienen informacion
            elseif gri1(n,m,k)==0
                cer1(k)= cer1(k)+1;
            end
            
            if gri1(n,m,k)>0
                grif1(ii,k) = gri1(n,m,k);
                %grif1: es una matriz con la informacion de los pixeles
                %correspondientes a la vegetacion. Sin embargo, incluyen
                %CEROS debido a que ii puede tener valores altos en algunos
                %plots
                plan1(k)=plan1(k)+1;
                %plan1(k): es el numero de pixeles correspondientes a la vegetacion 
                ii=ii+1;
            end
            
                       
            m=m+1;% ESTO ES X
        end
        n=n+1;
    end    
end


% gri1 :  con los vertices de los rectangulos que detectan y encierran a
% cada una de los plots, gri1 guarda la informacion por pixel en cada una
% de los recatngulo (detectores de objetos)

   

totalpix1=n*m;
cer1=cer1';
plan1=plan1';
%totalpix: es el numero total MAXIMO de pixeles de la grilla 1

%{
for k=1:length(stats)
    
    verde(k)=largorec(k)*anchorec(k)-(nul1(k)+cer1(k));
    xxx=[zeros(1,verde(k)];
    planta(ii,k)=xxx;    
    ii=1;   
    %for i=1:area2(k,3)-area2(k,1)+1
    for i=1:m %ESTO ES Y
        %for j=1:area2(k,4)-area2(k,2)+1 
        for j=1:n %ESTO ES X
     %{
            if gri1(j,i,k)<0                
                nul(k)=nul(k)+1;
                % nul(k): son los pixeles al intetriro del rectangulo que deteccata 
                % objetos y que no tienen informacion
            elseif gri1(j,i,k)==0
                cer(k)= cer(k)+1;
                % cer(k): son los pixeles correspondientes al suelo (CERO value) dentro
                % cada plot 
                       end            
            %}
            
            if gri1(j,i,k)>0
                griff1(ii,k) = gri1(j,i,k);
                xxx=[gri1(j,i,k)];
                %grif1: es una matriz con la informacion de los pixeles
                %correspondientes a la veegtacion. Sin embargo, incluyen
                %CEROS debido a que ii puede tener valores altos en algunos
                %plots
                
                ii=ii+1;
            end
        end
    end        
end
 

    

%plan1(length(stats))=0;
%plan1(k): es el numero de pixeles correspondientes a la vegetacion 

for k=1:length(stats)
    for i=1:ii
        if grif1(i,k)>0
            plan1(k)=plan1(k)+1;
        end
    end 
end
        
%}