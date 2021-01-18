import sympy as sp                

#FUNCION DE DH
def sTdh(a, alpha, d, th):
    cth = sp.cos(th); sth = sp.sin(th)
    ca = sp.cos(alpha); sa = sp.sin(alpha)
    Tdh = sp.Matrix([[cth, -ca*sth,  sa*sth, a*cth],
                     [sth,  ca*cth, -sa*cth, a*sth],
                     [0,        sa,     ca,      d],
                     [0,         0,      0,      1]])
    return Tdh

#MAIN
q1,q2,q3,q4,q5=sp.symbols('q1,q2,q3,q4,q5')
d1,d2,d3,d4,d5=sp.symbols('d1,d2,d3,d4,d5')
a1,a2,a3,a4,a5=sp.symbols('a1,a2,a3,a4,a5')
#transformadas homogeneas
T01=sTdh(0, sp.pi/2, d1, q1)
T12=sTdh(a2, 0, 0, q2)
T23=sTdh(a3, 0, 0, q3)
T34=sTdh(0, sp.pi/2, 0, q4)
T45=sTdh(0, 0, d5, q5)

print(T01)
print(T12)
print(T23)
print(T34)
print(T45)
resultado = sp.simplify(T34*T23*T12*T01)
print("*********************************")
print(resultado)
