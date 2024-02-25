function Gaussian_Elimination_with_Partial_Pivoting(A, B)
% Entradas:
% Matriz aumentada de coeficientes A = [mxn]
% Vector de constantes B = [mx1]

% Obtener las dimensiones de la matriz A
[m, n] = size(A);

% Inicialización del vector solución con ceros
solucion = zeros(m, 1);

% Matriz M para almacenar los multiplicadores durante la eliminación de Gauss
M = zeros(m, m-1);

% === Eliminación hacia adelante ===

for k = 1:m-1
    % Realizando el pivoteo parcial (reordenamiento de filas para evitar la división por cero)
    for p = k+1:m
        % Comprobando si el valor absoluto del elemento actual es mayor que el del pivote
        if abs(A(p, k)) > abs(A(k, k))
            % Intercambio de filas de A y elementos correspondientes de B
            A([k, p], :) = A([p, k], :);
            B([k, p]) = B([p, k]);
        end
    end
    
    % Calculando y almacenando los multiplicadores de eliminación en la matriz M
    for i = k+1:m
        % Calculando el multiplicador para la fila i
        M(i, k) = A(i, k) / A(k, k);
        
        % Actualizando la fila i de A y el elemento correspondiente de B
        for j = k+1:n
            A(i, j) = A(i, j) - M(i, k) * A(k, j);
        end
        B(i) = B(i) - M(i, k) * B(k);
    end
end

% === Eliminación hacia atrás ===

% Con la ultima ecuación se resuelve para la variable correspondiente
solucion(m) = B(m) / A(m, m);
for i = m-1:-1:1
    % Sumatoria de los productos de los coeficientes y las variables ya encontradas
    sumatoria = 0;
    for j = i+1:m
        sumatoria = sumatoria + A(i, j) * solucion(j);
    end
    
    % Calculo del valor de la variable correspondiente
    solucion(i) = (B(i) - sumatoria) / A(i, i);
end

fprintf('\n---Procedimiento terminado---\n \nEl vector solución es:\n');
fprintf('%f\n', solucion);
end