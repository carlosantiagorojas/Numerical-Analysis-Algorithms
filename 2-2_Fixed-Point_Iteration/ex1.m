function ex1( f, a, b, N, erroraprox )
ar = zeros(1, N); % Preasignamos el tamaño del vector para almacenar las aproximaciones de la raíz
br = zeros(1, N); % Preasignamos el tamaño del vector para almacenar el número de iteraciones
k = 1; % Inicializamos el contador de iteraciones
x0 = a; % Inicializamos x0 con el valor inicial del intervalo

while (k <= N)
    % Calculamos los valores de la función en los extremos del intervalo
    z = f(b);
    w = f(a);
    
    % Calculamos la aproximación de la raíz mediante la interpolación lineal
    c = b - (z * (b-a)) / (z-w);
    
    % Almacenamos la aproximación y el número de iteración
    ar(k) = c;
    br(k) = k;
    
    % Mostramos la raíz en cada operación
    fprintf('Iteración %d: Raíz aproximada = %f\n', k, c);
    
    % Verificamos si se alcanzó el error de aproximación deseado
    if (abs(c-x0)/c) < erroraprox/100
        fprintf('La raíz aproximada después de %d iteraciones es: %f', k, c);
        return
    end
    
    % Actualizamos los extremos del intervalo según el método de bisección
    if w*f(c) < 0
        b = c;
    else
        a = c;
    end
    
    % Incrementamos el contador de iteraciones y actualizamos x0
    k = k + 1;
    x0 = c;
end
end
