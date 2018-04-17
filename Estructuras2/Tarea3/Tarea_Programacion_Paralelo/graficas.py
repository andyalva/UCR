import matplotlib.pyplot as plt

n_array = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

n_other = [150, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300,
           1400, 1500]

single_core = [0.162, 0.729, 0.985, 1.606, 2.298, 4.033, 4.557, 6.712, 6.61,
               7.798]

single_other = [16.474, 28.947, 63.544, 111.11, 165.087, 247.151, 320.501,
                426.488, 527.782, 649.291, 773.797, 942.974, 1065.24,
                1248.06, 1416.52]

multiple_core = [0.086, 0.169, 0.278, 0.465, 0.558, 0.937, 1.091, 1.855, 2.998,
                 3.622]

multiple_other = [15.105, 27.107, 58.766, 110.228, 155.461, 247.424,
                  305.16, 420.866, 519.48, 641.158, 754.622, 936.39, 1070.82,
                  1249.35, 1408.44]

plt.plot(n_array, single_core)
plt.title('single-thread')
plt.ylabel('tiempo de ejecucion [ms]')
plt.xlabel('Cantidad de numeros complejos')
plt.show()

plt.plot(n_array, multiple_core)
plt.title('4-thread')
plt.ylabel('tiempo de ejecucion [ms]')
plt.xlabel('Cantidad de numeros complejos')
plt.show()


plt.plot(n_array, single_core, 'r--', n_array, multiple_core, 'bs')
plt.title('single_core vs 4-thread')
plt.ylabel('tiempo de ejecucion [ms]')
plt.xlabel('Cantidad de numeros complejos')
plt.show()
