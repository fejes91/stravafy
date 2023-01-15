import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:stravafy/core/model/view_model.dart';

@injectable
class MapScreenVM extends ViewModel {
  @factoryMethod
  MapScreenVM();

  Stream<List<LatLng>> get polylines => Stream.value(_getPolylinePoints());

  List<LatLng> _getPolylinePoints() {
    const polylineString =
        'sdp`H{{ksB}EyDmxB~Dif@}LoD`GaBgAqA@qAqBuDaLyExB}@jDf@nRc@fj@a@~Hq@~@]w@LoJaAJGrJvAlFs@lXwDfVRh@lEBo@nK`Bv@wA[X`Bx@t@~l@tMmJltA|@b@F`A}Gjy@D`Ad@XFxB[pZu@{@Dd@YA`@fA{DfK~EbJbPvODt@y@lBfIxImE|HmBfGBrFnDvVZvHU`Fc@PwCl`@aErp@YrQ`@lM_@{Eg@Cq_@vMcOzPgHrKyFzFcAzB~@xAa@lF~BpMaEH_CjDn@}Bs@uAs@uHc@aA{@bBUfAn@tE?bKoA|LqM`[eH`GzCcC~@@jB~BdFdCnA~ErAjBAfJl@tDS|EaBxPEdG{AzEOpCNpEzApAP~@iEkAqD|@cSfJ_EP{FdF{FnA_AlKv@lDbBhAnCk@f@jCzAtA`DvJd@~E`ExEmD`AKt@`A~D`BpEfDbCr@pEdBzCn@xD?rI^n@~DeA~AZfAjIqCVaApAqE^iIfBat@|b@sB]iNgIsUkPk@f@oH`V_@DsJmI~BkJeC?oJcM{Cg@kAz@{S`Es@tB}@LVh@}@]eArBuA_AqKhTy@hA}@JoR{ZwMsGsRkOoCpH}MeI_BmA{BuEuFuAoDmCqAoGeF_KwBAqD}D_FyCgOeF}NdAyTaGaIa@Mf@Ue@oPyAd@zKaA`ViArEmBnD{ElHiEnMe@lOz@|AhA`K_AdKcBvDwAXmBpBsI~ToAxI_FfIeBlAsCpKmHhHwFtDkA~AiGvOiJ~KoGpZwBpAgN^wKbEkCzDiJzHqAT}FtFyBpHsDjGeChCwG|C{AfCyFdF_AmAoEOCkC_@fAuEKM}T?nNdFTZ_Lq@sRfBmMvKuUpFkF~@mBjF}TjU_s@FeA}A{@eAsBvFkMbEoGrT}OvHiKtAp@g@gB~AyIfRmh@?aB}BmCdHrK|EkAjWy^|O_WOmBp@z@r@a@nMa^jQo[j@gEXiPtGwQvIec@xCeX|DsM|CkTtHoZ|F_Kri@en@tZig@~CoHrZqf@~EuNxN_VlFsLbJuNlBeFfBk@NmPlD_^fC_[`DeEzMwK`UDdNgTrFoMbF}PbTqd@lEsLnFiRgA}Jjh@gl@{IoUr@gAvG}MxCeAhGaKKgC`AcCrOoQ`C[hJcHpH_D`GyBrOqCbQcA]qBG{S`@]PgBfF{C`DlIlFgCpDjD`AQve@lLftAcBfb@gA~@YzCeEvIoPD}CiB{Y~@oMpAkBb@_@dAl@lBjHUfX';
    return decodePolyline(polylineString)
        .map((coordinatePair) =>
            LatLng(coordinatePair[0].toDouble(), coordinatePair[1].toDouble()))
        .toList();
  }
}
