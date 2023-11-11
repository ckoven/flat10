#!/bin/bash

scratchdir=/glade/derecho/scratch/charlie/flat10/
data_root=/glade/campaign/cgd/tss/lawrence/archive/
explist=('b.e21.B1850.f09_g17.FLAT10ctrl-esm.001' 'b.e21.B1850.f09_g17.FLAT10-esm.001' 'b.e21.B1850.f09_g17.FLAT10-zec.001' 'b.e21.B1850.f09_g17.FLAT10-cdr.001')

for exp in "${explist[@]}"
do
    echo $exp
    cd $data_root/$exp/lnd/hist
    ncrcat -cv NEE,PCO2,PBOT,ALTMAX,TOTVEGC,TOTSOMC,TOTLITC,CWDC,GPP,NPP,HR,COL_FIRE_CLOSS,FAREA_BURNED,TLAI,EFLX_LH_TOT $exp.clm2.h0.*.nc $scratchdir/$exp.lnd_vars.nc &
    cd $data_root/$exp/atm/hist
    ncrcat -cv TMCO2,SFCO2,SFCO2_LND,SFCO2_OCN,SFCO2_FFF,TREFHT,PRECC,PRECL $exp.cam.h0.*.nc $scratchdir/$exp.atm_vars.nc &
    cd $data_root/$exp/ocn/hist
    ncrcat -cv SSH,FG_CO2,MOC $exp.pop.h.[0-9][0-9]*.nc $scratchdir/$exp.ocn_vars.nc &    
done
