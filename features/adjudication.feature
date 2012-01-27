Feature: adjudicator resolves orders
	In order to automatically run games for the rails-diplomacy website
	As a adjudicator
	I want to resolve orders

  Scenario Outline: Test case outline
    Given current state "<currentstate>"
    When I adjudicate a set of "<orders>"
    Then the "<adjudication>" should be correct. 
    
  Scenarios: Simple Tests
    | currentstate | orders | adjudication |
    | Rus:FStP(nc) | FStP(nc)-Bar | S |
    | Rus:FStP(sc) | FStP(sc)-Bar | F |
    
  Scenarios: Diplomacy Adjudicator Test Cases - Basic Checks
    | currentstate | orders | adjudication |
    | Eng:FNth | FNth-Pic | F |
    | Eng:ALiv | ALiv-Iri | F |
    | Ger:FKie | FKie-Mun | F |
    | Ger:FKie | FKie-Kie | F |
    | Eng:FNth,AYor,ALiv Ger:ALon,AWal | FNthCAYor-Yor,AYor-Yor,ALivSAYor-Yor,FLon-Yor,AWalSFLon-Yor | FFFSS |
   #| Eng:FLon | FLon-Nth | F | 6.A.6 The order is given by Germany, this makes no sense in our context
    | Eng:FLon,FNth | FLon-Bel,FNthCALon-Bel | FF |
    | Ita:AVen,ATyr Aus:FTri | AVen-Tri,ATyrSAVen-Tri,FTriSFTri | SSF |
    | Ita:FRom | FRom-Ven | F |
    | Aus:AVen Ita:FRom,AApu | AVenH,FRomSAApu-Ven,AApu-Ven | SFF |
    | Aus:AVie Ita:AVen | AVie-Tyr,AVen-Tyr | FF |
    | Aus:AVie Ger:AMun Ita:AVen | AVie-Tyr,AMun-Tyr,AVen-Tyr | FFF |
    
  Scenarios: Diplomacy Adjudicator Test Cases - Supports and Dislodges
    | currentstate | orders | adjudication |
    | Aus:FAdr,ATri Ita:AVen,ATyr | FAdrSATri-Ven,ATri-Ven,AVenH,ATyrSAVen | SFSS |
    | Aus:FAdr,ATri,AVie Ita:AVen,ATyr | FAdrSATri-Ven,ATri-Ven,AVie-Tyr,AVenH,ATyrSAVen | SSFSF |
    | Aus:FAdr,ATri Ita:AVen,FIon | FAdrSATri-Ven,ATri-Ven,AVenH,FIon-Adr | FFSF |
    | Ger:ABer,FKie Rus:FBal,APru | ABerSFKie,FKieSABer,FBalSAPru-Ber,APru-Ber | FSSF |
    | Ger:ABer,FKie,AMun Rus:FBal,APru | ABerSAMun-Sil,FKieSABer,AMun-Sil,FBalSAPru-Ber,APru-Ber | FSSSF |
    | Ger:ABer,FBal,FPru Rus:FLvn,FBot | ABer-Swe,FBalCABer-Swe,FPruSFBal,FLvn-Bal,FBotSFLvn-Bal | SSSFS |
    | Ger:FBal,FPru Rus:FLvn,FBot,AFin | FBal-Swe,FPruSFBal,FLvn-Bal,FBotSFLvn-Bal,AFin-Swe | FFSSF |
    | Aus:FIon,ASer,AAlb Tur:AGre,ABul | FIonH,ASerSAAlb-Gre,AAlb-Gre,AGre-Nap,ABulSAGre | SSSFF |
    | Ita:AVen,ATyr Aus:AAlb,ATri | AVen-Tri,ATyrSAVen-Tri,AAlbSATri-Ser,ATriH | SSFS |
    | Ger:ABer,FKie,AMun | ABerH,FKie-Ber,AMunSFKie-Ber | SFS |
    | Ger:ABer,FKie,AMun Rus:AWar | ABer-Pru,FKie-Ber,AMunSFKie-Ber,AWar-Pru | FFSF |
    | Aus:FTri,AVie Ita:AVen | FTriH,AVieSAVen-Tri,AVen-Tri | SSF |
    | Aus:FTri,AVie Ita:AVen,FApu | FTri-Adr,AVieSAVen-Tri,AVen-Tri,FApu-Adr | FSFF |
    | Aus:FTri,AVie Ita:AVen,ATyr,FAdr | FTriH,AVieSAVen-Tri,AVen-Tri,ATyrSAVen-Tri,FAdrSAVen-Tri | SSSSS |
    | Rus:FCon,FBla Tur:FAnk | FConSFBla-Ank,FBla-Ank,FAnk-Con | SSF |
    | Eng:ALon,FNth Fra:FEng,ABel | ALonH,FNthCABel-Lon,FEngSABel-Lon,ABel-Lon | SSSS |
    | Rus:FCon,FBla Tur:FAnk,ASmy,AArm | FConSFBla-Ank,FBla-Ank,FAnk-Con,ASmySFAnk-Con,AArm-Ank | FFSSF |
    | Rus:FCon,FBla,ABul Tur:FAnk,ASmy,AArm | FConSFBla-Ank,FBla-Ank,ABulSFCon,FAnk-Con,ASmySFAnk-Con,AArm-Ank | SSSSSS |
    | Rus:FCon,FBla,ASmy Tur:FAnk | FConSFBla-Ank,FBla-Ank,ASmySFAnk-Con,FAnk-Con | SSSF |
    | Eng:FLon,FNth,AYor Fra:FEng | FLonSFNth-Eng,FNth-Eng,AYor-Lon,FEngH | SSFS |
    | Aus:FTri Ita:AVen,ATyr Ger:AMun Rus:ASil,ABer | FTriH,AVen-Tri,ATyrSAVen-Tri,AMun-Tyr,ASil-Mun,ABerSASil-Mun | SFFFSS |
    | Ger:FKie,ABur Rus:AMun,ABer | FKie-Mun,ABurSFKie-Mun,AMun-Kie,ABerSAMun-Kie | FFSS |
    | Ita:FLyo,FWes Fra:FSpa(nc),FMar | FLyo-Spa(sc),FWesSFLyo-Spa(sc),FSpa(nc)-Lyo,FMarSFSpa(nc)-Lyo | SSFF |
   #| Fra:AMar,FSpa(sc)... 
    | Ger:ABer,FKie Rus:FBal,APru | ABerSAPru,FKieSABer,FBalSAPru-Ber,APru-Ber | FSSF | 
    | Ger:ABer,FKie Rus:FBal,APru | ABerSAPru-Sil,FKieSABer,FBalSAPru-Ber,APru-Ber | FSSF |
    | Eng:FSwe,FDen Ger:ABer Rus:FBal,FPru | FSwe-Bal,FDenSFSwe-Bal,ABerH,FBalCABer-Lvn,FPruSFBal | FSSFS |
    | Aus:ABud Rus:FRum Tur:FBla,ABul | ABudSFRum,FRum-Hol,FBla-Rum,ABulSFBla-Rum | SFFS |
   #| Aus:ABud Rus:FRum Tur:FBla,ABul | ABudSFRum,FRum-Bul(sc),FBla-Rum,ABulSFBla-Rum | SFFS | perhaps without meaning for us, no corrections will ever be made
   #| Ita:Aeg Rus:FCon...
    | Aus:ARum Tur:FBla | ARum-Arm,FBlaSARum-Arm | FS |
    | Eng:FEdi,ALiv Fra:FLon Ger:AYor | FEdiSALiv-Yor,ALiv-Yor,FLonSAYor,AYor-Hol | SSSF |
    | Aus:ASer,AVie Rus:AGal Tur:ABul | ASer-Bud,AVie-Bud,AGalSASer-Bud,ABul-Ser | SFSS |
    | Ger:ABer,ASil,FBal Ita:APru Rus:AWar,ALvn | ABer-Pru,ASilSABer-Pru,FBalSABer-Pru,APruSALvn-Pru,AWarSALvn-Pru,ALvn-Pru | SSSFSF |
    
  Scenarios: Diplomacy Adjudicator Test Cases - Head to head battles and beleaguered garrison
    | currentstate | orders | adjudication |
    | Ger:ABer,FKie,ASil Rus:APru | ABer-Pru,FKie-Ber,ASilSABer-Pru,APru-Ber | SSSF |
    | Ger:ABer,FKie,AMun | ABer-Kie,FKie-Ber,AMunSABer-Kie | FFS |
    | Ger:ABer,AMun Eng:FKie | ABer-Kie,AMunSFKie-Ber,FKie-Ber | FSF |
    | Ger:FHol,FHel,FSka Fra:FNth,FBel Eng:FEdi,FYor,FNor Aus:AKie,ARuh | FHol-Nth,FHelSFHol-Nth,FSkaSFHol-Nth,FNth-Hol,FBelSFNth-Hol,FEdiSFNor-Nth,FYorSFNor-Nth,FNor-Nth,AKieSARuh-Hol,ARuh-Hol | FSSFSSSFSF |
    
  Scenarios: Diplomacy Adjudicator Test Cases - Convoys
    | currentstate | orders | adjudication |
    | Tur:AGre,FAeg,FCon,FBla | AGre-Sev,FAegCAGre-Sev,FConCAGre-Sev,FBlaCAGre-Sev | FFFF |
    | Eng:FEng,ALon Fra:APar | FEngCALon-Bre,ALon-Bre,APar-Bre | SFF |
    | Eng:FEng,ALon,FMAO Fra:APar | FEngCALon-Bre,ALon-Bre,FMAOSALon-Bre,APar-Bre | SSSF |
    | Eng:FNth,ALon Ger:FSka | FNthCALon-Hol,ALon-Hol,FSka-Nth | SSF |
    | Eng:FNth,ALon Fra:FEng,FBel Ger:FSka,FDen | FNthCALon-Hol,ALon-Hol,FEng-Nth,FBelSFEng-Nth,FSka-Nth,FDenSFSka-Nth | SSFSFS |
