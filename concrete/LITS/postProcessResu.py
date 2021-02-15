print '-----Program Started-----'
#-----------LOAD MODULES------------
import numpy as np
import matplotlib
import matplotlib.cm as cm
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
#import scipy.interpolate


W=2.0
BB=0.05
FS=6
GR=0.5+0.5*(5**0.5)
matplotlib.rcParams.update({'font.size': FS})

f_ELAS= open('HC.resu','r')

Totalheight=36.4*0.0254      


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                                          DATA
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




#-------------------------------------------ELAS
SIZZ_ELAS=[]
TEMP_ELAS=[]
INST_LIST_ELAS=[]
SIZZ_ELAS_mm=[]
sim_inst=[]

extract_flag=0

for line in f_ELAS:

	if 'CHAMP AUX NOEUDS DE NOM SYMBOLIQUE  SIGM_NOEU ' in line:
		extract_flag+=1
	if 'CHAMP AUX NOEUDS DE NOM SYMBOLIQUE  TEMP' in line:
		extract_flag = 0
	
	line = line.strip()
	
	if extract_flag > 0:
		columns=line.split()
		
		if 'N1 ' in line:
			print(columns)
			SIZZ_ELAS.append(float(columns[-4]))
		if 'INST:' in line:
			sim_inst.append(float(columns[-1]))
				

f_ELAS.close()
SIZZ_ELAS_mm=[None]*len(SIZZ_ELAS)
 
for i in range(0,len(SIZZ_ELAS)):
	SIZZ_ELAS_mm[i]=(SIZZ_ELAS[i]*(1e-6))
	print(SIZZ_ELAS_mm)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                                          DRAW GRAPH
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Target T(t) loads (From HC.comm)
#Ti=[0,2400,3600,7200,10800,12000,16800,21600,22800]
Ti=[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8]
Te=[20,100,140,20,140,180,20,180,220]

#interpolate temperature based on time step recutting during simulation
sim_T = np.interp(sim_inst,Ti,Te)

fig=plt.figure()
plt.xlabel('Temperature(Celsius)')
plt.ylabel('Stress (MPa)')
plt.plot(sim_T, SIZZ_ELAS_mm, '-bx')
#plt.ylim(-50,100)
#plt.xlim(20,220)

plt.legend(fontsize=FS)
fig.set_size_inches(W*GR,W)
fig.savefig('TEMP_SIZZ_ELAS.png',bbox_inches='tight',pad_inches=BB )
plt.close(fig)




