part of 'pages.dart';

class OngkirPage extends StatefulWidget {
  const OngkirPage({super.key});

  @override
  State<OngkirPage> createState() => _OngkirPageState();
}

class _OngkirPageState extends State<OngkirPage> {
  bool isLoading = false;
  String selectedKurir = 'JNE';
  var kurir = [
    'JNE',
    'POS Indonesia',
    'TIKI',
  ];
  final beratController = TextEditingController();

  dynamic provId;
  dynamic provinceOriginData;
  dynamic provinceDestinationData;
  dynamic selectedOriginProvince;
  dynamic selectedDestinationProvince;
  Future<List<Province>> getProvinces() async {
    dynamic listProvince;
    await MasterDataService.getProvince().then(
      (value) {
        setState(
          () {
            listProvince = value;
          },
        );
      },
    );
    return listProvince;
  }

  dynamic originCityId;
  dynamic destinationCityId;
  dynamic originCityData;
  dynamic destinationCityData;
  dynamic selectedOriginCity;
  dynamic selectedDestinationCity;
  Future<List<City>> getCities(dynamic provId) async {
    dynamic listCity;
    await MasterDataService.getCity(provId).then(
      (value) {
        setState(
          () {
            listCity = value;
          },
        );
      },
    );
    return listCity;
  }

  List<Costs> listCosts = [];
  Future<dynamic> getCostsData() async {
    await RajaOngkirService.getMyOngkir(originCityId, destinationCityId,
            int.parse(beratController.text), selectedKurir)
        .then(
      (value) {
        setState(
          () {
            listCosts = value;
            isLoading = false;
          },
        );
        print(listCosts.toString());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    provinceOriginData = getProvinces();
    provinceDestinationData = getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Hitung Ongkir'),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                //* Form Input
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.4,
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(6),
                                ),
                                child: DropdownButton(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  value: selectedKurir,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  items: kurir
                                      .map(
                                        (String items) => DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (String? newDropdownValue) {
                                    setState(
                                      () {
                                        selectedKurir = newDropdownValue!;
                                      },
                                    );
                                  },
                                  underline: const SizedBox(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.45,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: beratController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value == null || value == 0
                                        ? 'Berat tidak boleh 0 gram'
                                        : null,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.scale_outlined),
                                  hintText: '1000',
                                  labelText: 'Berat (gram)',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Origin
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Origin',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Provinsi asal
                                SizedBox(
                                  width: width * 0.4,
                                  child: FutureBuilder<List<Province>>(
                                    builder: ((context, snapshot) {
                                      if (snapshot.hasData) {
                                        return InputDecorator(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.all(6),
                                          ),
                                          child: DropdownButton(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            underline: const SizedBox(),
                                            isExpanded: true,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            value: selectedOriginProvince,
                                            iconSize: 32,
                                            hint: selectedOriginProvince == null
                                                ? const Text('Pilih Provinsi')
                                                : Text(selectedOriginProvince
                                                    .province),
                                            items: snapshot.data!.map<
                                                DropdownMenuItem<Province>>(
                                              (Province value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value.province.toString(),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (newValue) {
                                              setState(
                                                () {
                                                  selectedOriginProvince =
                                                      newValue;
                                                  provId =
                                                      selectedOriginProvince
                                                          .provinceId;
                                                },
                                              );
                                              selectedOriginCity = null;
                                              originCityData =
                                                  getCities(provId);
                                            },
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Text("Tidak ada data.");
                                      }
                                      return UiLoading.loadingDropdown();
                                    }),
                                    future: provinceOriginData,
                                  ),
                                ),
                                // Kota asal
                                SizedBox(
                                  width: width * 0.45,
                                  child: FutureBuilder<List<City>>(
                                    builder: ((context, snapshot) {
                                      if (selectedOriginProvince == null) {
                                        return const Text(
                                          'Pilih Provinsi dulu',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        );
                                      } else {
                                        if (snapshot.hasData) {
                                          return InputDecorator(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.all(6),
                                            ),
                                            child: DropdownButton(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                              underline: const SizedBox(),
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              value: selectedOriginCity,
                                              iconSize: 32,
                                              hint: selectedOriginCity == null
                                                  ? const Text('Pilih Kota')
                                                  : Text(selectedOriginCity
                                                      .cityName),
                                              items: snapshot.data!
                                                  .map<DropdownMenuItem<City>>(
                                                (City value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                      value.cityName.toString(),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (newValue) {
                                                setState(
                                                  () {
                                                    selectedOriginCity =
                                                        newValue;
                                                    originCityId =
                                                        selectedOriginCity
                                                            .originCityId;
                                                  },
                                                );
                                                originCityData = newValue;
                                                originCityData =
                                                    getCities(provId);
                                              },
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Text("Tidak ada data.");
                                        }
                                        return UiLoading.loadingDropdown();
                                      }
                                    }),
                                    future: originCityData,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Destination
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 32,
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Destination',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Provinsi tujuan
                                SizedBox(
                                  width: width * 0.4,
                                  child: FutureBuilder<List<Province>>(
                                    builder: ((context, snapshot) {
                                      if (snapshot.hasData) {
                                        return InputDecorator(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.all(6),
                                          ),
                                          child: DropdownButton(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            underline: const SizedBox(),
                                            isExpanded: true,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            value: selectedDestinationProvince,
                                            iconSize: 32,
                                            hint: selectedDestinationProvince ==
                                                    null
                                                ? const Text('Pilih Provinsi')
                                                : Text(
                                                    selectedDestinationProvince
                                                        .province),
                                            items: snapshot.data!.map<
                                                DropdownMenuItem<Province>>(
                                              (Province value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value.province.toString(),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (newValue) {
                                              setState(
                                                () {
                                                  selectedDestinationProvince =
                                                      newValue;
                                                  provId =
                                                      selectedDestinationProvince
                                                          .provinceId;
                                                },
                                              );
                                              selectedDestinationCity = null;
                                              destinationCityData =
                                                  getCities(provId);
                                            },
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Text("Tidak ada data.");
                                      }
                                      return UiLoading.loadingDropdown();
                                    }),
                                    future: provinceDestinationData,
                                  ),
                                ),
                                // Kota tujuan
                                SizedBox(
                                  width: width * 0.45,
                                  child: FutureBuilder<List<City>>(
                                    builder: ((context, snapshot) {
                                      if (selectedDestinationProvince == null) {
                                        return const Text(
                                          'Pilih Provinsi dulu',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        );
                                      } else {
                                        if (snapshot.hasData) {
                                          return InputDecorator(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.all(6),
                                            ),
                                            child: DropdownButton(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                              underline: const SizedBox(),
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              value: selectedDestinationCity,
                                              iconSize: 32,
                                              hint: selectedDestinationCity ==
                                                      null
                                                  ? const Text('Pilih Kota')
                                                  : Text(selectedDestinationCity
                                                      .cityName),
                                              items: snapshot.data!
                                                  .map<DropdownMenuItem<City>>(
                                                (City value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                      value.cityName.toString(),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (newValue) {
                                                setState(
                                                  () {
                                                    selectedDestinationCity =
                                                        newValue;
                                                    destinationCityId =
                                                        selectedDestinationCity
                                                            .destinationCityId;
                                                  },
                                                );
                                                destinationCityData = newValue;
                                                destinationCityData =
                                                    getCities(provId);
                                              },
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Text("Tidak ada data.");
                                        }
                                        return UiLoading.loadingDropdown();
                                      }
                                    }),
                                    future: destinationCityData,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            // Perhitungan Estimasi Harga Ongkir
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  MasterDataService.getMahasiswa();
                                  // if (originCityId == null ||
                                  //     destinationCityId == null ||
                                  //     selectedKurir.isEmpty ||
                                  //     beratController.text.isEmpty) {
                                  //   UiToast.toastErr("Semua kolom harus diisi");
                                  // } else {
                                  //   getCostsData();
                                  // }
                                  // Fluttertoast.showToast(
                                  //   msg: selectedOriginProvince == null ||
                                  //           selectedOriginCity == null ||
                                  //           selectedDestinationProvince ==
                                  //               null ||
                                  //           selectedDestinationCity == null
                                  //       ? 'Pilih Origin dan/atau Destination dulu'
                                  //       : 'Origin: ${selectedOriginCity.cityName}, Destination: ${selectedDestinationCity.cityName}',
                                  //   toastLength: Toast.LENGTH_LONG,
                                  //   gravity: ToastGravity.BOTTOM,
                                  //   timeInSecForIosWeb: 1,
                                  //   backgroundColor:
                                  //       selectedOriginProvince == null ||
                                  //               selectedOriginCity == null ||
                                  //               selectedDestinationProvince ==
                                  //                   null ||
                                  //               selectedDestinationCity == null
                                  //           ? Style.red500
                                  //           : Style.green500,
                                  //   textColor: Style.white,
                                  // );
                                },
                                icon: const Icon(Icons.calculate_outlined),
                                label: const Text('Hitung Estimasi Harga'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Menampilkan data
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: listCosts.isEmpty
                        ? const Center(
                            child: Text('Tidak ada data'),
                          )
                        : ListView.builder(
                            itemCount: listCosts.length,
                            itemBuilder: (context, index) {
                              return LazyLoadingList(
                                initialSizeOfItems: 10,
                                loadMore: () {},
                                index: index,
                                hasMore: true,
                                child: CardOngkirWidget(listCosts[index]),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
          isLoading == true ? UiLoading.loading() : Container(),
        ],
      ),
    );
  }
}
