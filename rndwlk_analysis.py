import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

data = np.loadtxt(r'Traj_rdnwlk.dat')

X = data[:,0]
Y = data[:,1]

R2 = X*X + Y*Y

t = np.arange(1,len(R2)+1)
t = t.reshape(-1, 1)
modelo = LinearRegression()
modelo.fit(t,R2)

slope = modelo.coef_[0]
intercept = modelo.intercept_

print("Coeficiente de difusão:", slope/4)
print("Intercepto:", intercept)

if slope <= 0:
    print('Subdifusivo')
elif (slope - 1) > 1e-4:
    print('Difusivo simples')
else:
    print('Superdifusivo')
