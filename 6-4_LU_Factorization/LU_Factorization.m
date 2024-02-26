function LU_Factorization(A)
% Entrada:
%   - A: Matriz cuadrada de tamaño m x m que se desea descomponer
% Salidas:
%   - L: Matriz triangular inferior
%   - U: Matriz triangular superior

% Inicialización y obtención del tamaño de la matriz A
[m,~] = size(A);

% Inicializa la matriz triangular superior U con ceros
U = zeros(m);
% Inicializa la matriz triangular inferior L con ceros
L = zeros(m);

% Inicialización de la diagonal de L con unos
for j = 1:m
    L(j,j) = 1;
end

% Copia de la primera fila de A a la primera fila de U
for j = 1:m
    U(1,j) = A(1,j);
end

% Paso 3: Cálculo de los elementos de L y U
for i = 2:m
    % Calcula los elementos de la fila i de L y U
    for j = 1:m
        for k = 1:i-1
            % Cálculo de la suma para calcular los elementos de L
            suma_L = 0;
            if k ~= 1
                for p = 1:k-1
                    suma_L = suma_L + L(i,p) * U(p,k);
                end
            end
            % Cálculo del elemento de L usando la fórmula de la factorización LU
            L(i,k) = (A(i,k) - suma_L) / U(k,k);
        end

         % Cálculo de los elementos de la fila i de U
        for k = i:m
             % Cálculo de la suma para calcular los elementos de U
             suma_U = 0;
           for p = 1:i-1
               suma_U = suma_U + L(i,p) * U(p,k);
           end
           % Cálculo del elemento de U usando la fórmula de la factorización LU
           U(i,k) = A(i,k) - suma_U;
        end
    end
end

% Imprimir las matrices
fprintf('\n---Procedimiento terminado---\n');
fprintf('\nResultado de la matriz L:\n');
disp(L);
fprintf('\nResultado de la matriz U:\n');
disp(U);
end