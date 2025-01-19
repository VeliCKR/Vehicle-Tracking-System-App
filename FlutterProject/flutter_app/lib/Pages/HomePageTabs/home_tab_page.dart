import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/Blocks/max_min_home_screen_bloc.dart';
import 'package:flutter_app/CustomWidgets/custom_home_maximised_data.dart';
import 'package:flutter_app/CustomWidgets/custom_home_minimised_data.dart';
import 'package:flutter_app/Resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key, this.title});
  final String? title;

  @override
  HomeTabPageState createState() => HomeTabPageState();
}

class HomeTabPageState extends State<HomeTabPage> with TickerProviderStateMixin {
  final _maxMinHomeScreenBloc = MaxMinHomeScreenBloc();
  late GoogleMapController _controller;

  Set<Marker> markers = {}; // Araç marker'ı
  Set<Polyline> polylines = {}; // Yol işaretleri

  // Başlangıç noktası (New York)
  LatLng _vehiclePosition = const LatLng(40.730610, -73.935242);
  LatLng? _destination; // Kullanıcının seçtiği hedef noktası
  double _vehicleSpeed = 0.0; // Hız bilgisi
  StreamSubscription<Position>? _positionStream;

  BitmapDescriptor? _carIcon; // Sabit araç simgesi
  double _zoomLevel = 14.4746; // Harita yakınlaşma seviyesi

  // Google Maps başlangıç konumu
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.730610, -73.935242),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _loadCarIcon();  // Sabit araç simgesini yükleyin
    _startTracking();
  }

  // Sabit araç simgesini yükleyin
  void _loadCarIcon() async {
    BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(10, 10)), 'assets/images/car_blue.png');
    setState(() {
      _carIcon = bitmapDescriptor;
      _updateMarker(bitmapDescriptor);  // Başlangıçta araç marker'ı güncellensin
    });
  }

  // **Konum izleme ve hareket simülasyonu**
  void _startTracking() async {
    // Yol çizgisi (Polyline)
    if (_destination != null) {
      _drawRoute();
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Her 5 metrede bir güncelle
      ),
    ).listen((Position position) {
      setState(() {
        _vehiclePosition = LatLng(position.latitude, position.longitude);
        _vehicleSpeed = position.speed; // Hızı güncelle
        // Sabit araç simgesini kullanarak marker'ı güncelleyin
        if (_carIcon != null) {
          _updateMarker(_carIcon!);
        }
      });

      // Kamerayı aracın konumuna taşı
      _controller.animateCamera(CameraUpdate.newLatLng(_vehiclePosition));
    });

    // Başlangıçta bir resim gösterelim
    if (_carIcon != null) {
      setState(() {
        _updateMarker(_carIcon!);
      });
    }

    // Eğer hedef varsa, aracı hedefe doğru simüle et
    if (_destination != null) {
      _simulateVehicleMovement(_carIcon!);
    }
  }

  // **Aracı hedefe doğru düzgün bir şekilde hareket ettirme**
  void _simulateVehicleMovement(BitmapDescriptor bitmapDescriptor) async {
    if (_destination == null) return;

    double latDiff = (_destination!.latitude - _vehiclePosition.latitude) / 100;
    double lngDiff = (_destination!.longitude - _vehiclePosition.longitude) / 100;

    int speed = 1; // Başlangıç hızı
    int phase = 1; // Hız değişim evresi: 1-30, 2-20, 3-60, 4-50

    while ((_vehiclePosition.latitude - _destination!.latitude).abs() > 0.0001 ||
        (_vehiclePosition.longitude - _destination!.longitude).abs() > 0.0001) {
      await Future.delayed(const Duration(milliseconds: 200));

      // Hız değişim döngüsü
      switch (phase) {
        case 1:
        // Hız artıyor: 1'den 30'a kadar
          if (speed < 30) {
            speed++;
          } else {
            phase = 2; // 30'a ulaştığında 20'ye düşmeye başla
          }
          break;
        case 2:
        // Hız azalıyor: 30'dan 20'ye kadar
          if (speed > 20) {
            speed--;
          } else {
            phase = 3; // 20'ye ulaştığında 60'a artmaya başla
          }
          break;
        case 3:
        // Hız artıyor: 20'den 60'a kadar
          if (speed < 60) {
            speed++;
          } else {
            phase = 4; // 60'a ulaştığında 50'ye düşmeye başla
          }
          break;
        case 4:
        // Hız azalıyor: 60'tan 50'ye kadar
          if (speed > 50) {
            speed--;
          } else {
            phase = 5; // 50'ye ulaştığında durma evresine geç
          }
          break;
        case 5:
        // Durma evresi: Hız sıfırda kalır
          break;
      }

      setState(() {
        _vehiclePosition = LatLng(
          _vehiclePosition.latitude + latDiff,
          _vehiclePosition.longitude + lngDiff,
        );
        _vehicleSpeed = speed.toDouble(); // Hızı her adımda güncelle
        // Sabit araç simgesiyle marker'ı güncelle
        if (_carIcon != null) {
          _updateMarker(_carIcon!);
        }
      });

      // Kamerayı sürekli olarak aracın bulunduğu konuma taşı
      _controller.animateCamera(CameraUpdate.newLatLng(_vehiclePosition));
    }
  }






  // **Marker Güncelleme**
  void _updateMarker(BitmapDescriptor bitmapDescriptor) {
    setState(() {
      markers.clear();
      markers.add(Marker(
        markerId: const MarkerId("vehicle"),
        position: _vehiclePosition,
        icon: bitmapDescriptor,  // Sabit araç simgesi her zaman kullanılacak
        infoWindow: InfoWindow(
          title: "Araç Konumu",
          snippet: "Hız: ${_vehicleSpeed.toStringAsFixed(2)} m/s",
        ),
      ));
    });
  }

  // **Yolu Çizme (Polyline)**
  void _drawRoute() {
    if (_destination != null) {
      setState(() {
        polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          points: [_vehiclePosition, _destination!],
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  // Kullanıcının harita üzerinde tıkladığı konumu al
  void _onMapTapped(LatLng position) {
    setState(() {
      _destination = position;
      _drawRoute();
      if (_carIcon != null) {
        _simulateVehicleMovement(_carIcon!);
      }
    });
  }

  // **Harita yakınlaştırma ve uzaklaştırma**
  void _zoomIn() {
    setState(() {
      _zoomLevel++;
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _vehiclePosition, zoom: _zoomLevel),
      ));
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel--;
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _vehiclePosition, zoom: _zoomLevel),
      ));
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 60,
              color: R.colors.loginButtonColor,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                markers: markers,
                polylines: polylines,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                onTap: _onMapTapped, // Harita tıklama işlevi
                onCameraMove: (CameraPosition position) {
                  setState(() {
                    _zoomLevel = position.zoom;
                  });
                },
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Hız: ${_vehicleSpeed.toStringAsFixed(2)} m/s",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: BoxDecoration(
                    color: R.colors.whiteMainColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              R.strings.arrivalInformation,
                              style: TextStyle(
                                color: R.colors.homeTextColor,
                                fontFamily: R.strings.fontName,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder(
                        bloc: _maxMinHomeScreenBloc,
                        builder: (context, bool i) {
                          return AnimatedContainer(
                            height: (!i) ? 160 : 40,
                            duration: const Duration(milliseconds: 320),
                            child: (!i)
                                ? const CustomisedHomeMaximisedData()
                                : const CustomisedHomeMinimisedData(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add, size: 30, color: Colors.black),
                  onPressed: _zoomIn,
                ),
                IconButton(
                  icon: Icon(Icons.remove, size: 30, color: Colors.black),
                  onPressed: _zoomOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






