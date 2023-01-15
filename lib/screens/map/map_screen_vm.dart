import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/core/model/view_model.dart';

@injectable
class MapScreenVM extends ViewModel {
  @factoryMethod
  MapScreenVM();

  Stream<List<List<LatLng>>> get polylines =>
      Stream.value(_getPolylinePoints());

  List<List<LatLng>> _getPolylinePoints() {
    const polylineStrings = [
      'sdp`H{{ksB}EyDmxB~Dif@}LoD`GaBgAqA@qAqBuDaLyExB}@jDf@nRc@fj@a@~Hq@~@]w@LoJaAJGrJvAlFs@lXwDfVRh@lEBo@nK`Bv@wA[X`Bx@t@~l@tMmJltA|@b@F`A}Gjy@D`Ad@XFxB[pZu@{@Dd@YA`@fA{DfK~EbJbPvODt@y@lBfIxImE|HmBfGBrFnDvVZvHU`Fc@PwCl`@aErp@YrQ`@lM_@{Eg@Cq_@vMcOzPgHrKyFzFcAzB~@xAa@lF~BpMaEH_CjDn@}Bs@uAs@uHc@aA{@bBUfAn@tE?bKoA|LqM`[eH`GzCcC~@@jB~BdFdCnA~ErAjBAfJl@tDS|EaBxPEdG{AzEOpCNpEzApAP~@iEkAqD|@cSfJ_EP{FdF{FnA_AlKv@lDbBhAnCk@f@jCzAtA`DvJd@~E`ExEmD`AKt@`A~D`BpEfDbCr@pEdBzCn@xD?rI^n@~DeA~AZfAjIqCVaApAqE^iIfBat@|b@sB]iNgIsUkPk@f@oH`V_@DsJmI~BkJeC?oJcM{Cg@kAz@{S`Es@tB}@LVh@}@]eArBuA_AqKhTy@hA}@JoR{ZwMsGsRkOoCpH}MeI_BmA{BuEuFuAoDmCqAoGeF_KwBAqD}D_FyCgOeF}NdAyTaGaIa@Mf@Ue@oPyAd@zKaA`ViArEmBnD{ElHiEnMe@lOz@|AhA`K_AdKcBvDwAXmBpBsI~ToAxI_FfIeBlAsCpKmHhHwFtDkA~AiGvOiJ~KoGpZwBpAgN^wKbEkCzDiJzHqAT}FtFyBpHsDjGeChCwG|C{AfCyFdF_AmAoEOCkC_@fAuEKM}T?nNdFTZ_Lq@sRfBmMvKuUpFkF~@mBjF}TjU_s@FeA}A{@eAsBvFkMbEoGrT}OvHiKtAp@g@gB~AyIfRmh@?aB}BmCdHrK|EkAjWy^|O_WOmBp@z@r@a@nMa^jQo[j@gEXiPtGwQvIec@xCeX|DsM|CkTtHoZ|F_Kri@en@tZig@~CoHrZqf@~EuNxN_VlFsLbJuNlBeFfBk@NmPlD_^fC_[`DeEzMwK`UDdNgTrFoMbF}PbTqd@lEsLnFiRgA}Jjh@gl@{IoUr@gAvG}MxCeAhGaKKgC`AcCrOoQ`C[hJcHpH_D`GyBrOqCbQcA]qBG{S`@]PgBfF{C`DlIlFgCpDjD`AQve@lLftAcBfb@gA~@YzCeEvIoPD}CiB{Y~@oMpAkBb@_@dAl@lBjHUfX',
      'o{{`HyxhsBq@f@CTPCb@k@Pi@b@{@z@gCJCF?E??BDAVH\\b@JK\\q@^cApAqEb@gB@e@KOMK@Kl@]LM`@Qt@o@|@k@dCeAdFeB|Ao@nAc@v@c@tA]pAOtCIHE`@ELFBFCDH?`@Gn@[^C`@XTQZi@nCcBNQd@a@p@a@PGjCkBd@MRKnA}@h@m@|@o@pAs@XSDMlAw@x@Sl@]d@[z@eAVOJC^Wr@Yp@}@FWs@mCy@wBBF?CDFBJ',
      'y~eaH_}urBFPr@?H\\GpTpFnFr@`BzCdBQx@eUhUoYjIoChCwIbNeCK]}BsKnBkArACj@x@vENbC{ClAF~Ao@p@cM|I_AtA_E|CqQfM{@~D{FhK}AdBcFzD{GpJ}HjIsCfEsFzLmAj@sAGaGiBkCxH_F|PNzBh@bB\\tCDdI}AzDeA`G{BhG}AzCgCjDeCfFS`H~@rSwBjIjArAv@~AdA^A|@v@hD?h@a@`B_CjDkFlLRtAdAjEt@x@`Cp@tCzGrJdEzFlErCrADZeTtl@mAZGvCOr@}ARYtq@Lr@wBlGgBf@s@|HiGzTyBjEiCxCc@fBC|E`AjDEfFl@~Iz@hFXnD^jN\\tDDrH_@pLj@bAGrCNzChApDpCrA|B]rCr@jCvC`BxCXhAbF~Cde@fzAFl@XZtCYfDrB~]{XTdD~DxRt@|BOs@pBhBvBOj@p@~@KzAqCXGLThB}@\\Lx@bBd@@bBgA@p@pA|DlCkAdAj@jK_GlGmEtAStAaA}LeIm@qBcAaAkB{DmBkCq@cFu@eEVkCjAkDVoCr@eBhAqGbFgJpAgEPwJxA{@Dm@dTkQj@y@FmB_A}A_M}FwIsHmFiDaFeHyA{GqEw@MYh@yAp@iHp@mAfAsArCgAlAcChB}B|BoGtBo@fCgErAmAj@kAb@mAiCy@kCbCcBFqD{EaDcCyAcBcAc@sHXoBy@aD]m@f@o@~AaAPoCq@mBwAqEEyB}@_BJiD|@_A~Au@|BkAZm@p@yD~H}A|@_@vCmAr@aCyBuBmD_B}AkByCRmBzGmYuEuKgEeIi@cEc@uAw@u@iAWoAiCe@{EB{NOkCyPm@eDwA{EaDPgAlOwa@hCoI_DqAmDqC{EmCiEcBSg@QqCDiFZ{EWa@_@J}BdJyC{@g@DoAfBaChFkAlAL_D?{BY}TpCYGwLnDaJxAuGjAwCtFq@|A_AlAeCdDyMzCvBx@D|@nAlCI`CyE~BqBf@eAlB_B`C_Av@kDt@aBRwAtBgEtBmIr@aAdCuApFoJH\\Q_@lE}GTy@^iBgB}GWaEl@kDzBwD|GwDnA[bFo@ZpARHdE{DjB@`FwDtB_@a@In@aCV_GZoB~@}AJqAsBqEYg@LoBh@aCr@qA@Ui@iAEw@f@{DOe@FWq@m@uAEgBj@g@WtBcDhBwApBMhDyCrDuBdAj@wEsRL_@tCmAoAyIL{@pAiAtJ}ARDTrBtBTZQtIaNtBqB|BgAtOyDhFmBzUsVMa@uBUoAaAa@wAmFgFDsU',
      'qko`HuhmsBBe@Mw@DYHWBMGc@@YMw@W{@Yk@Ok@A]QgAUw@w@}Bi@gAO_Be@yB[kAUgAm@oAKGCWK_@A[Us@LOZMl@?|@EbA@j@G~@Bb@KnAKfB[N@`@Q^EZOd@GRSJi@ZqA\\}@v@aBVWjAe@T]?y@LaB@c@Ak@BGVSn@EjAm@lAa@h@g@`AY|@Uz@CbA_@b@K`@E^I~Ac@ZEt@Y^It@G|ASlAWdBYv@Kb@Ct@Mf@M`@Sd@EtAWh@OPClBc@r@UhBc@z@g@t@W\\Q~@o@`@K\\CXK^]^e@\\O^_@lAw@rAwAlA{@`@a@\\H\\LPv@A@U@WBc@XqAvAs@b@SV]X]NeBnAYZSJc@ZiAj@a@NUNYZ]Zg@Pc@?g@^MDe@H_@LSJEF}@b@_Ah@g@Rm@NsAMJCBEGFQAYBWGI?kAFc@CW?g@F[PWVy@h@]^k@b@?LPj@h@tBUdAR`BBn@CNc@DaACKFGZD`CFv@?jBEbAAfAGt@@pBKxA?z@BRAJAIC@EjBFlBC~C@|AWnB]X}AEa@Ce@Ig@AQHEzBK`CDT@dAEhBEx@BfBO|@G`B@p@Cl@Gr@GXFv@AZ?nAK|@KVc@Ee@Ie@Cq@?sD[k@?aAS[A]Bc@?o@Gw@@GWc@G]AS@WCYFOE[@c@IIDCEKAQd@Gn@K^B|@GtAAj@Bz@ALBn@PXF`@IdABh@NJFGJ@?CF@z@BVHV?p@CrAJRGj@NjA@HB@PIj@FfAAPkA`@',
      'qdp`H{{ksBuG{CySIsWjAs}@fByJGgKgCWn@w@GsWwFaAPoBlC}AkAuAPc@k@qE_OiCf@kBjBGtAk@xAj@`Se@bi@o@bJ{@GHeKw@kAeUvCiGfBcJ~DcXdYk`@ne@_b@|c@`@tD?bC^nAmCrImAzFeDtJeIlQcAjDcA[uDjIyBdHcErLqEvKaO`VsCb@Yf@d@vAtRnKdDdEl@rDDtBcA|QmAfLuDfT[jDGhFe@t@sCj@uBzAeCvFmE`CmAlC_@fDrAjLCvCkCrKwC`EgB~GkCzFWvB|@|IOzGtA`D|BxA~CNtFrEdHzAtAU`C_EjApGeBjKiGtP_EdHyDzPW|Co@lBGjJ_@rCj@lEwBfLpAnEsBtAi@nC@xBt@hC[nDmB|Aq@pB{B`CsF|AeFzD{GzLaCl@}AbCu@^iD`@s@Yu@eBeAmG}BqAkC{Gc@mCgB}DJdBcCpD_Bx@gCtCaF[eKpFyCvCmCxEq@jCu@nFaAhDu@bIMhJa@v@eBl@eF~EgFtJIzA`Bt@vEc@fCuBhBs@jIoId@_IlAcObCuK`LsJeCxAgGjGqBpIe@bKf@dB|Av@rB}@zFmGxFiJxDwBdGdAfBzAbCrEhDzAlGvAjCO|C|BbBAxCaDpByHzGoHdE}JhMeR\\uAkAQ]kAfAsCjAxAWnATr@tVfLfNQ|LqDvB@lGfClBfBdKbXnOxUt@zF}@hNb@lFrCpK~GdKfItFvLdF\\vAk@zBTb@pBEvHoD~Dy@fFpAnE~EdApBpDhLUhFaArAgBzGvCtKnArBhGtB~Fv@tCpE~DtB|HC`GoFtCkFb@eBvC{ClIoMdEuPlFmJrB{Bk@yG@aBg@cC@aDvEs`@BaCeBk_@qDud@j@_K?eDoFgw@uBm_@GaIZeQ~AaR^qJ~Fwy@]kIoDqVBkEfB{FrEeIuH_Jd@{A@sAsCwBeDmEaFwEkCqEsAoAOs@lBmGZeBI_A\\AK]XCKa@r@Sh@sK@_EOe@PuCEiBc@eAz@qMN?a@iC|@gGfBuUdCab@fBgSdCcc@x@wGki@wJ}FeBNeAx@C_Bm@rAiKXQl@uDnB{VVsH@sQj@uJIy@q@y@oFQI`Oj@T\\s@f@yKb@}f@{@}R^s@FwAjAqAzCgA|F`PfBC~Az@lCwC`@CjWzF~@JRi@fKvBvJH`hAyBdM{@lKBZj@?dAtDvEdAHp@xEGhGPfCv@~BxApA|Pc@tYbA|Bn@zHb@xIvBf]rOVQzBgNKkAiHsGdAkKiDsCkD}@sj@wB',
    ];
    return polylineStrings
        .map(
          (polylineString) => decodePolyline(polylineString)
              .map(
                (coordinatePair) => LatLng(
                  coordinatePair[0].toDouble(),
                  coordinatePair[1].toDouble(),
                ),
              )
              .toList(),
        )
        .toList();
  }
}
