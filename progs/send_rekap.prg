


TEXT TO csql noshow
SELECT b.tgl_trm, SUM(IF(a.jenis1='01',a.pokok1+a.denda1,0)+IF(a.jenis2='01',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='01',a.pokok3+a.denda3,0)+IF(a.jenis4='01',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='01',a.pokok5+a.denda5,0)+IF(a.jenis6='01',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='01',a.pokok7+a.denda7,0)+IF(a.jenis8='01',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='01',a.pokok9+a.denda9,0)+IF(a.jenis10='01',a.pokok10+a.denda10,0)) AS 'npkb_p',
       SUM(IF(a.jenis1='01',1,0)+IF(a.jenis2='01',1,0)+IF(a.jenis3='01',1,0)+IF(a.jenis4='01',1,0)+
       	   IF(a.jenis5='01',1,0)+IF(a.jenis6='01',1,0)+IF(a.jenis7='01',1,0)+IF(a.jenis8='01',1,0)+
       	   IF(a.jenis9='01',1,0)+IF(a.jenis10='01',1,0)) AS 'jpkb_p',
       SUM(IF(a.jenis1='06A',a.pokok1+a.denda1,0)+IF(a.jenis2='06A',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='06A',a.pokok3+a.denda3,0)+IF(a.jenis4='06A',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='06A',a.pokok5+a.denda5,0)+IF(a.jenis6='06A',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='06A',a.pokok7+a.denda7,0)+IF(a.jenis8='06A',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='06A',a.pokok9+a.denda9,0)+IF(a.jenis10='06A',a.pokok10+a.denda10,0)) AS 'npkb_d',
       SUM(IF(a.jenis1='06A',1,0)+IF(a.jenis2='06A',1,0)+IF(a.jenis3='06A',1,0)+IF(a.jenis4='06A',1,0)+
       	   IF(a.jenis5='06A',1,0)+IF(a.jenis6='06A',1,0)+IF(a.jenis7='06A',1,0)+IF(a.jenis8='06A',1,0)+
       	   IF(a.jenis9='06A',1,0)+IF(a.jenis10='06A',1,0)) AS 'jpkb_d',
       SUM(IF(f.jenis1='01',f.pokok1+f.denda1,0)+IF(f.jenis2='01',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='01',f.pokok3+f.denda3,0)+IF(f.jenis4='01',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='01',f.pokok5+f.denda5,0)+IF(f.jenis6='01',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='01',f.pokok7+f.denda7,0)+IF(f.jenis8='01',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='01',f.pokok9+f.denda9,0)+IF(f.jenis10='01',f.pokok10+f.denda10,0)) AS 'npkbt_p',
       SUM(IF(f.jenis1='01',1,0)+IF(f.jenis2='01',1,0)+IF(f.jenis3='01',1,0)+IF(f.jenis4='01',1,0)+
       	   IF(f.jenis5='01',1,0)+IF(f.jenis6='01',1,0)+IF(f.jenis7='01',1,0)+IF(f.jenis8='01',1,0)+
       	   IF(f.jenis9='01',1,0)+IF(f.jenis10='01',1,0)) AS 'jpkbt_p',
       SUM(IF(f.jenis1='06A',f.pokok1+f.denda1,0)+IF(f.jenis2='06A',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='06A',f.pokok3+f.denda3,0)+IF(f.jenis4='06A',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='06A',f.pokok5+f.denda5,0)+IF(f.jenis6='06A',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='06A',f.pokok7+f.denda7,0)+IF(f.jenis8='06A',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='06A',f.pokok9+f.denda9,0)+IF(f.jenis10='06A',f.pokok10+f.denda10,0)) AS 'npkbt_d',
       SUM(IF(f.jenis1='06A',1,0)+IF(f.jenis2='06A',1,0)+IF(f.jenis3='06A',1,0)+IF(f.jenis4='06A',1,0)+
       	   IF(f.jenis5='06A',1,0)+IF(f.jenis6='06A',1,0)+IF(f.jenis7='06A',1,0)+IF(f.jenis8='06A',1,0)+
       	   IF(f.jenis9='06A',1,0)+IF(f.jenis10='06A',1,0)) AS 'jpkbt_d',
	   SUM(IF(a.jenis1='02A',a.pokok1+a.denda1,0)+IF(a.jenis2='02A',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='02A',a.pokok3+a.denda3,0)+IF(a.jenis4='02A',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='02A',a.pokok5+a.denda5,0)+IF(a.jenis6='02A',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='02A',a.pokok7+a.denda7,0)+IF(a.jenis8='02A',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='02A',a.pokok9+a.denda9,0)+IF(a.jenis10='02A',a.pokok10+a.denda10,0)) AS 'nbbn1',
       SUM(IF(a.jenis1='02A',1,0)+IF(a.jenis2='02A',1,0)+IF(a.jenis3='02A',1,0)+IF(a.jenis4='02A',1,0)+
       	   IF(a.jenis5='02A',1,0)+IF(a.jenis6='02A',1,0)+IF(a.jenis7='02A',1,0)+IF(a.jenis8='02A',1,0)+
       	   IF(a.jenis9='02A',1,0)+IF(a.jenis10='02A',1,0)) AS 'jbbn1',
       SUM(IF(a.jenis1='06B',a.pokok1+a.denda1,0)+IF(a.jenis2='06B',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='06B',a.pokok3+a.denda3,0)+IF(a.jenis4='06B',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='06B',a.pokok5+a.denda5,0)+IF(a.jenis6='06B',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='06B',a.pokok7+a.denda7,0)+IF(a.jenis8='06B',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='06B',a.pokok9+a.denda9,0)+IF(a.jenis10='06B',a.pokok10+a.denda10,0)) AS 'dbbn1',
       SUM(IF(a.jenis1='06B',1,0)+IF(a.jenis2='06B',1,0)+IF(a.jenis3='06B',1,0)+IF(a.jenis4='06B',1,0)+
       	   IF(a.jenis5='06B',1,0)+IF(a.jenis6='06B',1,0)+IF(a.jenis7='06B',1,0)+IF(a.jenis8='06B',1,0)+
       	   IF(a.jenis9='06B',1,0)+IF(a.jenis10='06B',1,0)) AS 'jdbbn1',
       SUM(IF(f.jenis1='02A',f.pokok1+f.denda1,0)+IF(f.jenis2='02A',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='02A',f.pokok3+f.denda3,0)+IF(f.jenis4='02A',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='02A',f.pokok5+f.denda5,0)+IF(f.jenis6='02A',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='02A',f.pokok7+f.denda7,0)+IF(f.jenis8='02A',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='02A',f.pokok9+f.denda9,0)+IF(f.jenis10='02A',f.pokok10+f.denda10,0)) AS 'nbbn1t',
       SUM(IF(f.jenis1='02A',1,0)+IF(f.jenis2='02A',1,0)+IF(f.jenis3='02A',1,0)+IF(f.jenis4='02A',1,0)+
       	   IF(f.jenis5='02A',1,0)+IF(f.jenis6='02A',1,0)+IF(f.jenis7='02A',1,0)+IF(f.jenis8='02A',1,0)+
       	   IF(f.jenis9='02A',1,0)+IF(f.jenis10='02A',1,0)) AS 'jbbn1t',
       SUM(IF(f.jenis1='06B',f.pokok1+f.denda1,0)+IF(f.jenis2='06B',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='06B',f.pokok3+f.denda3,0)+IF(f.jenis4='06B',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='06B',f.pokok5+f.denda5,0)+IF(f.jenis6='06B',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='06B',f.pokok7+f.denda7,0)+IF(f.jenis8='06B',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='06B',f.pokok9+f.denda9,0)+IF(f.jenis10='06B',f.pokok10+f.denda10,0)) AS 'dbbn1t',
       SUM(IF(f.jenis1='06B',1,0)+IF(f.jenis2='06B',1,0)+IF(f.jenis3='06B',1,0)+IF(f.jenis4='06B',1,0)+
       	   IF(f.jenis5='06B',1,0)+IF(f.jenis6='06B',1,0)+IF(f.jenis7='06B',1,0)+IF(f.jenis8='06B',1,0)+
       	   IF(f.jenis9='06B',1,0)+IF(f.jenis10='06B',1,0)) AS 'jdbbn1t',
           SUM(IF(a.jenis1='02B',a.pokok1+a.denda1,0)+IF(a.jenis2='02B',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='02B',a.pokok3+a.denda3,0)+IF(a.jenis4='02B',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='02B',a.pokok5+a.denda5,0)+IF(a.jenis6='02B',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='02B',a.pokok7+a.denda7,0)+IF(a.jenis8='02B',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='02B',a.pokok9+a.denda9,0)+IF(a.jenis10='02B',a.pokok10+a.denda10,0)) AS 'nbbn2',
       SUM(IF(a.jenis1='02B',1,0)+IF(a.jenis2='02B',1,0)+IF(a.jenis3='02B',1,0)+IF(a.jenis4='02B',1,0)+
       	   IF(a.jenis5='02B',1,0)+IF(a.jenis6='02B',1,0)+IF(a.jenis7='02B',1,0)+IF(a.jenis8='02B',1,0)+
       	   IF(a.jenis9='02B',1,0)+IF(a.jenis10='02B',1,0)) AS 'jbbn2',
       SUM(IF(a.jenis1='06C',a.pokok1+a.denda1,0)+IF(a.jenis2='06C',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='06C',a.pokok3+a.denda3,0)+IF(a.jenis4='06C',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='06C',a.pokok5+a.denda5,0)+IF(a.jenis6='06C',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='06C',a.pokok7+a.denda7,0)+IF(a.jenis8='06C',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='06C',a.pokok9+a.denda9,0)+IF(a.jenis10='06C',a.pokok10+a.denda10,0)) AS 'dbbn2',
       SUM(IF(a.jenis1='06C',1,0)+IF(a.jenis2='06C',1,0)+IF(a.jenis3='06C',1,0)+IF(a.jenis4='06C',1,0)+
       	   IF(a.jenis5='06C',1,0)+IF(a.jenis6='06C',1,0)+IF(a.jenis7='06C',1,0)+IF(a.jenis8='06C',1,0)+
       	   IF(a.jenis9='06C',1,0)+IF(a.jenis10='06C',1,0)) AS 'jdbbn2',
       SUM(IF(f.jenis1='02B',f.pokok1+f.denda1,0)+IF(f.jenis2='02B',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='02B',f.pokok3+f.denda3,0)+IF(f.jenis4='02B',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='02B',f.pokok5+f.denda5,0)+IF(f.jenis6='02B',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='02B',f.pokok7+f.denda7,0)+IF(f.jenis8='02B',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='02B',f.pokok9+f.denda9,0)+IF(f.jenis10='02B',f.pokok10+f.denda10,0)) AS 'nbbn2t',
       SUM(IF(f.jenis1='02B',1,0)+IF(f.jenis2='02B',1,0)+IF(f.jenis3='02B',1,0)+IF(f.jenis4='02B',1,0)+
       	   IF(f.jenis5='02B',1,0)+IF(f.jenis6='02B',1,0)+IF(f.jenis7='02B',1,0)+IF(f.jenis8='02B',1,0)+
       	   IF(f.jenis9='02B',1,0)+IF(f.jenis10='02B',1,0)) AS 'jbbn2t',
       SUM(IF(f.jenis1='06C',f.pokok1+f.denda1,0)+IF(f.jenis2='06C',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='06C',f.pokok3+f.denda3,0)+IF(f.jenis4='06C',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='06C',f.pokok5+f.denda5,0)+IF(f.jenis6='06C',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='06C',f.pokok7+f.denda7,0)+IF(f.jenis8='06C',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='06C',f.pokok9+f.denda9,0)+IF(f.jenis10='06C',f.pokok10+f.denda10,0)) AS 'dbbn2t',
       SUM(IF(f.jenis1='06C',1,0)+IF(f.jenis2='06C',1,0)+IF(f.jenis3='06C',1,0)+IF(f.jenis4='06C',1,0)+
       	   IF(f.jenis5='06C',1,0)+IF(f.jenis6='06C',1,0)+IF(f.jenis7='06C',1,0)+IF(f.jenis8='06C',1,0)+
       	   IF(f.jenis9='06C',1,0)+IF(f.jenis10='06C',1,0)) AS 'jdbbn2t',
       SUM(IF(a.jenis1='07',a.pokok1+a.denda1,0)+IF(a.jenis2='07',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='07',a.pokok3+a.denda3,0)+IF(a.jenis4='07',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='07',a.pokok5+a.denda5,0)+IF(a.jenis6='07',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='07',a.pokok7+a.denda7,0)+IF(a.jenis8='07',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='07',a.pokok9+a.denda9,0)+IF(a.jenis10='07',a.pokok10+a.denda10,0)) AS 'nskrd',
       SUM(IF(a.jenis1='07',1,0)+IF(a.jenis2='07',1,0)+IF(a.jenis3='07',1,0)+IF(a.jenis4='07',1,0)+
       	   IF(a.jenis5='07',1,0)+IF(a.jenis6='07',1,0)+IF(a.jenis7='07',1,0)+IF(a.jenis8='07',1,0)+
       	   IF(a.jenis9='07',1,0)+IF(a.jenis10='07',1,0)) AS 'jskrd',       
       SUM(IF(a.jenis1='08',a.pokok1+a.denda1,0)+IF(a.jenis2='08',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='08',a.pokok3+a.denda3,0)+IF(a.jenis4='08',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='08',a.pokok5+a.denda5,0)+IF(a.jenis6='08',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='08',a.pokok7+a.denda7,0)+IF(a.jenis8='08',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='08',a.pokok9+a.denda9,0)+IF(a.jenis10='08',a.pokok10+a.denda10,0)) AS 'nsp3',
       SUM(IF(a.jenis1='08',1,0)+IF(a.jenis2='08',1,0)+IF(a.jenis3='08',1,0)+IF(a.jenis4='08',1,0)+
       	   IF(a.jenis5='08',1,0)+IF(a.jenis6='08',1,0)+IF(a.jenis7='08',1,0)+IF(a.jenis8='08',1,0)+
       	   IF(a.jenis9='08',1,0)+IF(a.jenis10='08',1,0)) AS 'jsp3',
       SUM(IF(a.jenis1='03',a.pokok1+a.denda1,0)+IF(a.jenis2='03',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='03',a.pokok3+a.denda3,0)+IF(a.jenis4='03',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='03',a.pokok5+a.denda5,0)+IF(a.jenis6='03',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='03',a.pokok7+a.denda7,0)+IF(a.jenis8='03',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='03',a.pokok9+a.denda9,0)+IF(a.jenis10='03',a.pokok10+a.denda10,0)) AS 'nswdk',
       SUM(IF(a.jenis1='03',1,0)+IF(a.jenis2='03',1,0)+IF(a.jenis3='03',1,0)+IF(a.jenis4='03',1,0)+
       	   IF(a.jenis5='03',1,0)+IF(a.jenis6='03',1,0)+IF(a.jenis7='03',1,0)+IF(a.jenis8='03',1,0)+
       	   IF(a.jenis9='03',1,0)+IF(a.jenis10='03',1,0)) AS 'jswdk',
       SUM(IF(a.jenis1='06D',a.pokok1+a.denda1,0)+IF(a.jenis2='06D',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='06D',a.pokok3+a.denda3,0)+IF(a.jenis4='06D',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='06D',a.pokok5+a.denda5,0)+IF(a.jenis6='06D',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='06D',a.pokok7+a.denda7,0)+IF(a.jenis8='06D',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='06D',a.pokok9+a.denda9,0)+IF(a.jenis10='06D',a.pokok10+a.denda10,0)) AS 'dswdk',
       SUM(IF(a.jenis1='06D',1,0)+IF(a.jenis2='06D',1,0)+IF(a.jenis3='06D',1,0)+IF(a.jenis4='06D',1,0)+
       	   IF(a.jenis5='06D',1,0)+IF(a.jenis6='06D',1,0)+IF(a.jenis7='06D',1,0)+IF(a.jenis8='06D',1,0)+
       	   IF(a.jenis9='06D',1,0)+IF(a.jenis10='06D',1,0)) AS 'jdswdk',
       SUM(IF(f.jenis1='03',f.pokok1+f.denda1,0)+IF(f.jenis2='03',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='03',f.pokok3+f.denda3,0)+IF(f.jenis4='03',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='03',f.pokok5+f.denda5,0)+IF(f.jenis6='03',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='03',f.pokok7+f.denda7,0)+IF(f.jenis8='03',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='03',f.pokok9+f.denda9,0)+IF(f.jenis10='03',f.pokok10+f.denda10,0)) AS 'nswdkt',
       SUM(IF(f.jenis1='03',1,0)+IF(f.jenis2='03',1,0)+IF(f.jenis3='03',1,0)+IF(f.jenis4='03',1,0)+
       	   IF(f.jenis5='03',1,0)+IF(f.jenis6='03',1,0)+IF(f.jenis7='03',1,0)+IF(f.jenis8='03',1,0)+
       	   IF(f.jenis9='03',1,0)+IF(f.jenis10='03',1,0)) AS 'jswdkt',
       SUM(IF(f.jenis1='06D',f.pokok1+f.denda1,0)+IF(f.jenis2='06D',f.pokok2+f.denda2,0)+
	       IF(f.jenis3='06D',f.pokok3+f.denda3,0)+IF(f.jenis4='06D',f.pokok4+f.denda4,0)+
	       IF(f.jenis5='06D',f.pokok5+f.denda5,0)+IF(f.jenis6='06D',f.pokok6+f.denda6,0)+
	       IF(f.jenis7='06D',f.pokok7+f.denda7,0)+IF(f.jenis8='06D',f.pokok8+f.denda8,0)+
	       IF(f.jenis9='06D',f.pokok9+f.denda9,0)+IF(f.jenis10='06D',f.pokok10+f.denda10,0)) AS 'dswdkt',
       SUM(IF(f.jenis1='06D',1,0)+IF(f.jenis2='06D',1,0)+IF(f.jenis3='06D',1,0)+IF(f.jenis4='06D',1,0)+
       	   IF(f.jenis5='06D',1,0)+IF(f.jenis6='06D',1,0)+IF(f.jenis7='06D',1,0)+IF(f.jenis8='06D',1,0)+
       	   IF(f.jenis9='06D',1,0)+IF(f.jenis10='06D',1,0)) AS 'jdswdkt',
       SUM(IF(a.jenis1='09',a.pokok1+a.denda1,0)+IF(a.jenis2='09',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='09',a.pokok3+a.denda3,0)+IF(a.jenis4='09',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='09',a.pokok5+a.denda5,0)+IF(a.jenis6='09',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='09',a.pokok7+a.denda7,0)+IF(a.jenis8='09',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='09',a.pokok9+a.denda9,0)+IF(a.jenis10='09',a.pokok10+a.denda10,0)) AS 'nakdp',
       SUM(IF(a.jenis1='09',1,0)+IF(a.jenis2='09',1,0)+IF(a.jenis3='09',1,0)+IF(a.jenis4='09',1,0)+
       	   IF(a.jenis5='09',1,0)+IF(a.jenis6='09',1,0)+IF(a.jenis7='09',1,0)+IF(a.jenis8='09',1,0)+
       	   IF(a.jenis9='09',1,0)+IF(a.jenis10='09',1,0)) AS 'jakdp',       
       SUM(IF(a.jenis1='10',a.pokok1+a.denda1,0)+IF(a.jenis2='10',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='10',a.pokok3+a.denda3,0)+IF(a.jenis4='10',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='10',a.pokok5+a.denda5,0)+IF(a.jenis6='10',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='10',a.pokok7+a.denda7,0)+IF(a.jenis8='10',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='10',a.pokok9+a.denda9,0)+IF(a.jenis10='10',a.pokok10+a.denda10,0)) AS 'niwkbu',
       SUM(IF(a.jenis1='10',1,0)+IF(a.jenis2='10',1,0)+IF(a.jenis3='10',1,0)+IF(a.jenis4='10',1,0)+
       	   IF(a.jenis5='10',1,0)+IF(a.jenis6='10',1,0)+IF(a.jenis7='10',1,0)+IF(a.jenis8='10',1,0)+
       	   IF(a.jenis9='10',1,0)+IF(a.jenis10='10',1,0)) AS 'jiwkbu',
       SUM(IF(a.jenis1='04',a.pokok1+a.denda1,0)+IF(a.jenis2='04',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='04',a.pokok3+a.denda3,0)+IF(a.jenis4='04',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='04',a.pokok5+a.denda5,0)+IF(a.jenis6='04',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='04',a.pokok7+a.denda7,0)+IF(a.jenis8='04',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='04',a.pokok9+a.denda9,0)+IF(a.jenis10='04',a.pokok10+a.denda10,0)) AS 'nstnk',
       SUM(IF(a.jenis1='04',1,0)+IF(a.jenis2='04',1,0)+IF(a.jenis3='04',1,0)+IF(a.jenis4='04',1,0)+
       	   IF(a.jenis5='04',1,0)+IF(a.jenis6='04',1,0)+IF(a.jenis7='04',1,0)+IF(a.jenis8='04',1,0)+
       	   IF(a.jenis9='04',1,0)+IF(a.jenis10='04',1,0)) AS 'jstnk',       
       SUM(IF(a.jenis1='05',a.pokok1+a.denda1,0)+IF(a.jenis2='05',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='05',a.pokok3+a.denda3,0)+IF(a.jenis4='05',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='05',a.pokok5+a.denda5,0)+IF(a.jenis6='05',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='05',a.pokok7+a.denda7,0)+IF(a.jenis8='05',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='05',a.pokok9+a.denda9,0)+IF(a.jenis10='05',a.pokok10+a.denda10,0)) AS 'ntnkb',
       SUM(IF(a.jenis1='05',1,0)+IF(a.jenis2='05',1,0)+IF(a.jenis3='05',1,0)+IF(a.jenis4='05',1,0)+
       	   IF(a.jenis5='05',1,0)+IF(a.jenis6='05',1,0)+IF(a.jenis7='05',1,0)+IF(a.jenis8='05',1,0)+
       	   IF(a.jenis9='05',1,0)+IF(a.jenis10='05',1,0)) AS 'jtnkb',
       SUM(IF(a.jenis1='06E',a.pokok1+a.denda1,0)+IF(a.jenis2='06E',a.pokok2+a.denda2,0)+
	       IF(a.jenis3='06E',a.pokok3+a.denda3,0)+IF(a.jenis4='06E',a.pokok4+a.denda4,0)+
	       IF(a.jenis5='06E',a.pokok5+a.denda5,0)+IF(a.jenis6='06E',a.pokok6+a.denda6,0)+
	       IF(a.jenis7='06E',a.pokok7+a.denda7,0)+IF(a.jenis8='06E',a.pokok8+a.denda8,0)+
	       IF(a.jenis9='06E',a.pokok9+a.denda9,0)+IF(a.jenis10='06E',a.pokok10+a.denda10,0)) AS 'nadm_d',
       SUM(IF(a.jenis1='06E',1,0)+IF(a.jenis2='06E',1,0)+IF(a.jenis3='06E',1,0)+IF(a.jenis4='06E',1,0)+
       	   IF(a.jenis5='06E',1,0)+IF(a.jenis6='06E',1,0)+IF(a.jenis7='06E',1,0)+IF(a.jenis8='06E',1,0)+
       	   IF(a.jenis9='06E',1,0)+IF(a.jenis10='06E',1,0)) AS 'jadm_d',
       SUM(if(LEFT(b.jenis,1)='7',1,0)) as rd2,
       SUM(if(LEFT(b.jenis,1)<>'7',1,0)) as rd4	   
	FROM pkb_BIASA a LEFT JOIN pkb_header b ON b.NO_DFT=a.NO_DFT AND b.tgl_DFT=a.tgl_DFT
	LEFT JOIN pkb_tunggak f ON b.NO_DFT=f.NO_DFT AND b.tgl_DFT=f.tgl_DFT
	WHERE  (b.tgl_trm)=?pdtgl_trans  GROUP BY b.tgl_trm	
						
ENDTEXT 																																																																																																																										Select BANK

asg = SQLExec(gnconnhandle,csql,'hBANK')
If asg >0
	ctgl = conv_tanggal(pdtgl_trans)
	cupt = pckdupt
	creset = "delete from hterima where tgl_trm = '"+Alltrim(ctgl)+"' and kode_upt ='"+ Alltrim(cupt)+"'"
	If del_data(creset)
		Select hbank
		csql = "insert into hterima values('"+Alltrim(ctgl)+"',"
		For F= 2 To Fcount('hbank')
			Select hbank
			cfield = Field(F)
			cIsi = Alltrim(Str(&cfield))
			csql = csql +"'"+cIsi+"',"
		Next
		csql=csql+"'"+cupt+"')"

		If ins_data(csql)
			Messagebox('Data Rekap Berhasil Di Kirim',0+64,'Ok',10)
		Else
			Messagebox('Data Rekap gagal Di Kirim',0+16,'Ok',10)
		Endif
	Endif
Endif

