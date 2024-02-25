function Gaussian_Elimination_with_Scaled_Partial_Pivoting(A, B)
% Entradas:
% Matriz aumentada de coeficientes A = [mxn]
% Vector de constantes B = [mx1]

% Obtener las dimensiones de la matriz A
[m, n] = size(A);

% Inicialización del vector solución con ceros
solucion = zeros(m, 1);

% Matriz M para almacenar los multiplicadores durante la eliminación de Gauss
M = zeros(m, m-1);

% Vector D para almacenar los escalados de las filas
D = ones(m, 1);

% === Eliminación hacia adelante ===
for k = 1:m-1
    % Encontrar el pivote con mayor valor absoluto en la columna actual
    valor_maximo = abs(A(k, k));
    fila_maximo = k;
    for i = k+1:m
        if abs(A(i, k)) > valor_maximo
            valor_maximo = abs(A(i, k));
            fila_maximo = i;
        end
    end
    
    % Intercambio de filas si es necesario
    if fila_maximo ~= k
        A([k, fila_maximo], :) = A([fila_maximo, k], :);
        B([k, fila_maximo]) = B([fila_maximo, k]);
        D([k, fila_maximo]) = D([fila_maximo, k]);
    end
    
    % Escalado de filas para mejorar la precisión
    if D(k) ~= 0
        A(k, :) = A(k, :) / D(k);
        B(k) = B(k) / D(k);
    end
    
    % Almacenar el escalado de la fila actual
    D(k) = A(k, k);
    
    % Calcular y almacenar los multiplicadores de eliminación
    for i = k+1:m
        M(i, k) = A(i, k) / A(k, k);
        
        % Actualizar la fila i de A y el elemento correspondiente de B
        for j = k+1:n
            A(i, j) = A(i, j) - M(i, k) * A(k, j);
        end
        B(i) = B(i) - M(i, k) * B(k);
    end
end

% === Eliminación hacia atrás ===
% Con la última ecuación se resuelve para la variable correspondiente
solucion(m) = B(m) / A(m, m);
for i = m-1:-1:1
    % Sumatoria de los productos de los coeficientes y las variables ya encontradas
    suma = 0;
    for j = i+1:m
        suma = suma + A(i, j) * solucion(j);
    end
    
    % Calculo del valor de la variable correspondiente
    solucion(i) = (B(i) - suma) / A(i, i);
end

% Imprimir el vector solución
fprintf('\n---Procedimiento terminado---\n\nEl vector solución es:\n');
fprintf('%f\n', solucion);
end