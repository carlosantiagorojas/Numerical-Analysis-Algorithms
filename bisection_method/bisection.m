% Metodo bisección Carlos Rojas

% Limpiar pantalla y eliminar variables
clc;
clear;
clear all;

% Permitir el uso de simbolos
syms x;

% Definir la función base
fx = (5 * cos(3 * x)) / x;

% Grafico de la función en el intervalo [pi/3,(2*pi)/3]
fplot((5*cos(3*x))/x,[pi/3,2*pi/3],'LineWidth',5)
grid on

% Digitar los valores iniciales del intervalo
fprintf('---Valor inicial del intervalo---\n');
a = input('Digite el valor de a: ');
b = input('Digite el valor de b: ');

% 1. Evaluar los valores de la función en a y b
fa = subs(fx, a);
fb = subs(fx, b);

% 2. Verificar si alguno de los extremos ya es una raiz
if fa == 0 || fb == 0
    if fa == 0
        fprintf('El valor de x en %8.5f ya es raiz\n', a);
    else 
        fprintf('El valor de x en %8.5f ya es raiz\n', b);
    end
else
    % 3. Evaluar que f(a) * f(b) < 0 garantizando que uno es positivo
    % y otro negativo para poder aplicar el método 

    if fa * fb > 0
        fprintf('El intervalo es invalido');
    else
        % (intentar con 1e-6)
        max_error = input('Digite el valor del error máximo permitido: ');

        % Evaluar el error inicial
        error = abs(b - a) / 2;
        
        i = 1;
        % Iterar hasta que el error sea menor al error maximo
        fprintf('\n---Aplicando metodo de bisección---\n');
        while error > max_error
            % 4. Evaluar el punto medio
            p_medio = (a + b) / 2;
            fprintf('Iteración No. %d, intervalo [%f,%f]',i, a ,b);
            fprintf(' la raíz más aproximada es:%8.5f\n', p_medio);
            % 5. Si f(a) * f(p_medio) > 0 entonces a = p_medio
            if fa * subs(fx, p_medio) > 0
                a = p_medio;
            else
                b = p_medio;
            end
            % 6. Evaluar el error
            error = abs(b - a) / 2;
            i  = i + 1;
        end
        fprintf('\n---Procedimiento terminado---\nLa solución aproximada es %8.5f\n',p_medio);
    end 
end

