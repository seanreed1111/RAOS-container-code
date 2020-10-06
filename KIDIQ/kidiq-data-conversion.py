import pandas as pd
import json

df = pd.read_csv("https://raw.githubusercontent.com/seanreed1111/MY-RAOS-LECTURE/main/DATA/KidIQ/data/kidiq.csv")

# compose the data
kid_score = [int(df.kid_score[i]) for i in df.index]
mom_hs = [int(df.mom_hs[i]) for i in df.index]
mom_iq = [float(df.mom_iq[i]) for i in df.index]
mom_work = [int(df.mom_work[i]) for i in df.index]
mom_age = [int(df.mom_age[i]) for i in df.index]

kidiq = {'N':434, 'K':4,
	'kid_score':kid_score, 
         'mom_hs':mom_hs,
         'mom_iq':mom_iq,
         'mom_work':mom_work ,
         'mom_age':mom_age 

  }
with open('kidiq.json', 'wt') as f:
    f.write(json.dumps(kidiq))
